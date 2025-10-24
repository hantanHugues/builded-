# Script pour corriger tous les chemins CSS et JS pour GitHub Pages
$repoName = "builded-"

# Trouver tous les fichiers HTML
$htmlFiles = Get-ChildItem -Path "." -Filter "*.html" -Recurse

Write-Host "Correction de $($htmlFiles.Count) fichiers HTML..."

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Corriger les chemins CSS
    $content = $content -replace 'href="/_next/static/css/', "href=`"/$repoName/_next/static/css/"
    
    # Corriger les chemins JS
    $content = $content -replace 'src="/_next/static/chunks/', "src=`"/$repoName/_next/static/chunks/"
    
    # Corriger les chemins API
    $content = $content -replace 'href="/api/', "href=`"/$repoName/api/"
    
    # Corriger autres assets
    $content = $content -replace 'src="/_next/', "src=`"/$repoName/_next/"
    $content = $content -replace 'href="/_next/', "href=`"/$repoName/_next/"
    
    # Sauvegarder le fichier
    Set-Content -Path $file.FullName -Value $content -Encoding UTF8
    
    Write-Host "✓ Corrigé: $($file.Name)"
}

Write-Host "Terminé! Tous les chemins ont été corrigés pour GitHub Pages."
