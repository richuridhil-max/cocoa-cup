$port = 8080
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")

try {
    $listener.Start()
    Write-Host "==========================================================" -ForegroundColor DarkYellow
    Write-Host "  Cocoa Cup Butter-Smooth Scroll Server Running!           " -ForegroundColor Yellow
    Write-Host "  URL: http://localhost:$port/                             " -ForegroundColor Green
    Write-Host "  Press Ctrl+C in this terminal window to stop.           " -ForegroundColor Gray
    Write-Host "==========================================================" -ForegroundColor DarkYellow

    $chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
    $edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

    if (Test-Path $chromePath) {
        Start-Process $chromePath -ArgumentList "--new-window", "--start-fullscreen", "http://localhost:$port/"
    } elseif (Test-Path $edgePath) {
        Start-Process $edgePath -ArgumentList "--new-window", "--start-fullscreen", "http://localhost:$port/"
    } else {
        Start-Process "http://localhost:$port/"
    }

    $baseDir = $PSScriptRoot
    if (-not $baseDir) { $baseDir = Get-Location }

    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $path = $request.Url.LocalPath.TrimStart('/')
        if ([string]::IsNullOrEmpty($path)) { $path = "index.html" }
        $path = [System.Uri]::UnescapeDataString($path)
        $filePath = Join-Path $baseDir $path

        if (Test-Path $filePath -PathType Leaf) {
            $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
            switch ($ext) {
                ".html" { $response.ContentType = "text/html; charset=utf-8" }
                ".css"  { $response.ContentType = "text/css" }
                ".js"   { $response.ContentType = "application/javascript" }
                ".png"  { $response.ContentType = "image/png" }
                ".jpg"  { $response.ContentType = "image/jpeg" }
                ".svg"  { $response.ContentType = "image/svg+xml" }
                default { $response.ContentType = "application/octet-stream" }
            }

            $bytes = [System.IO.File]::ReadAllBytes($filePath)
            $response.ContentLength64 = $bytes.Length
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $response.StatusCode = 404
            $err = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
            $response.OutputStream.Write($err, 0, $err.Length)
        }
        $response.Close()
    }
} finally {
    $listener.Stop()
}
