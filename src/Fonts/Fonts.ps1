$fonts = "https://github.com/be5invis/Iosevka/releases/download/v29.2.1/PkgTTC-Iosevka-29.2.1.zip"
$tmp = "C:\Windows\temp" 
$extractPath = "C:\temp\iosevka"

Invoke-WebRequest -Uri $fonts -OutFile $tmp
Expand-Archive -LiteralPath $tmp -DestinationPath $extractPath

# Find and install font files (.ttf)
Get-ChildItem -Path $extractPath -Recurse -Include *.ttf | ForEach-Object {
    $fontPath = $_.FullName

    Add-Type -TypeDefinition @"
        using System;
        using System.Runtime.InteropServices;

        public class FontInstaller {
            [DllImport("gdi32.dll")]
            public static extern int AddFontResource(string lpFilename);

            [DllImport("user32.dll")]
            public static extern int SendMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);
        }
"@

    [FontInstaller]::AddFontResource($fontPath)
    [FontInstaller]::SendMessage([IntPtr]::Zero, 0x1D, [IntPtr]::Zero, [IntPtr]::Zero)
}
