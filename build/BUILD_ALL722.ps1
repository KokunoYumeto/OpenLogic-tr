[CmdletBinding()]
param([string]$WorkDirectory='', [string]$OutputDirectory='')
$ErrorActionPreference='Stop'
$packageRoot=Split-Path -Parent $PSScriptRoot
$authority='9620cc73f9c8e0ad003c514a5d3748f29611c4c0'
if(-not $WorkDirectory){$WorkDirectory=Join-Path ([IO.Path]::GetTempPath()) ('openlogic-tr-all722-'+[guid]::NewGuid().ToString('N'))}
if(-not $OutputDirectory){$OutputDirectory=Join-Path $packageRoot 'output'}
New-Item -ItemType Directory -Path $WorkDirectory,$OutputDirectory -Force|Out-Null
$checkout=Join-Path $WorkDirectory 'OpenLogic'
if(Test-Path -LiteralPath $checkout){throw 'Refusing to overwrite an existing checkout.'}
git clone --filter=blob:none --no-checkout https://github.com/OpenLogicProject/OpenLogic.git $checkout
if($LASTEXITCODE -ne 0){throw 'Source clone failed.'}
git -C $checkout checkout --detach $authority
if($LASTEXITCODE -ne 0){throw 'Frozen source checkout failed.'}
if((git -C $checkout rev-parse HEAD).Trim() -ne $authority){throw 'Source commit identity mismatch.'}
$source=Join-Path $packageRoot 'source\locale\tr'
$target=Join-Path $checkout 'locale\tr'
New-Item -ItemType Directory -Path $target -Force|Out-Null
Get-ChildItem -LiteralPath $source | Copy-Item -Destination $target -Recurse -Force
if(-not(Test-Path -LiteralPath (Join-Path $target 'open-logic-all722.tex'))){throw 'Correction overlay is missing; unpack the original source ZIP and the correction ZIP together.'}
$mutex=[Threading.Mutex]::new($false,'Global\InterlanguageTeXSlotV1')
$acquired=$false;$abandoned=$false;$worker=$null
try{
  try{$acquired=$mutex.WaitOne([TimeSpan]::FromSeconds(60))}
  catch [Threading.AbandonedMutexException]{$acquired=$true;$abandoned=$true}
  if(-not $acquired){throw 'Shared TeX slot unavailable; no engine launched.'}
  if($abandoned){Write-Output 'Recovered abandoned TeX mutex.'}
  $timer=[Diagnostics.Stopwatch]::StartNew()
  $worker=Start-Process -FilePath (Get-Command latexmk.exe).Source -ArgumentList @('-pdf','-synctex=0','-interaction=nonstopmode','-halt-on-error','-file-line-error','open-logic-all722.tex') -WorkingDirectory $target -WindowStyle Hidden -PassThru -RedirectStandardOutput (Join-Path $OutputDirectory 'all722-build.stdout.txt') -RedirectStandardError (Join-Path $OutputDirectory 'all722-build.stderr.txt')
  while(-not $worker.WaitForExit(20000)){if($timer.Elapsed.TotalSeconds -gt 2400){$worker.Kill($true);$worker.WaitForExit();throw 'Captured build timed out.'}}
  $worker.WaitForExit()
  if($worker.ExitCode -ne 0){throw 'Reader compilation failed; inspect the captured logs.'}
  $log=[IO.File]::ReadAllText((Join-Path $target 'open-logic-all722.log'))
  if($log -match 'Undefined control sequence|Missing character:|There were undefined references|There were undefined citations'){throw 'Build diagnostics require correction.'}
  $out=Join-Path $OutputDirectory '00_OPENLOGIC_tr_COMPLETE_LINKED_READER_OLP-0722.pdf'
  Copy-Item -LiteralPath (Join-Path $target 'open-logic-all722.pdf') -Destination $out -Force
  Copy-Item -LiteralPath (Join-Path $target 'open-logic-all722.modules.csv') -Destination $OutputDirectory -Force
  Write-Output ('Reader SHA256: '+(Get-FileHash -LiteralPath $out -Algorithm SHA256).Hash.ToLower())
}finally{
  if($null -ne $worker -and -not $worker.HasExited){$worker.Kill($true);$worker.WaitForExit()}
  if($acquired){$mutex.ReleaseMutex()}
  $mutex.Dispose()
}
