$root = $PSScriptRoot
$port = 5500
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Serving $root on http://localhost:$port/"

$mime = @{
  ".html" = "text/html; charset=utf-8"
  ".css"  = "text/css; charset=utf-8"
  ".js"   = "application/javascript; charset=utf-8"
  ".svg"  = "image/svg+xml"
  ".png"  = "image/png"
  ".jpg"  = "image/jpeg"
  ".ico"  = "image/x-icon"
  ".pdf"  = "application/pdf"
  ".txt"  = "text/plain; charset=utf-8"
  ".xml"  = "application/xml; charset=utf-8"
}

while ($listener.IsListening) {
  $context = $listener.GetContext()
  $request = $context.Request
  $response = $context.Response

  $path = $request.Url.LocalPath
  $filePath = Join-Path $root ($path.TrimStart("/"))

  # Come GitHub Pages: una cartella serve il proprio index.html
  if (Test-Path $filePath -PathType Container) {
    $filePath = Join-Path $filePath "index.html"
  }

  if (Test-Path $filePath -PathType Leaf) {
    $ext = [System.IO.Path]::GetExtension($filePath)
    $contentType = $mime[$ext]
    if (-not $contentType) { $contentType = "application/octet-stream" }
    $bytes = [System.IO.File]::ReadAllBytes($filePath)
    $response.ContentType = $contentType
    $response.ContentLength64 = $bytes.Length
    $response.OutputStream.Write($bytes, 0, $bytes.Length)
  } else {
    $response.StatusCode = 404
    $notFoundPage = Join-Path $root "404.html"
    if (Test-Path $notFoundPage -PathType Leaf) {
      $bytes = [System.IO.File]::ReadAllBytes($notFoundPage)
      $response.ContentType = "text/html; charset=utf-8"
    } else {
      $bytes = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found")
      $response.ContentType = "text/plain"
    }
    $response.ContentLength64 = $bytes.Length
    $response.OutputStream.Write($bytes, 0, $bytes.Length)
  }
  $response.OutputStream.Close()
}
