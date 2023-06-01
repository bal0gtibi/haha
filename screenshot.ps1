Add-Type -AssemblyName System.Windows.Forms  ### not necessary in PowerShell_ISE
if ($([System.Windows.Forms.Clipboard]::ContainsImage())) {
    $image = [System.Windows.Forms.Clipboard]::GetImage()
	$savepath = [Environment]::GetFolderPath("User")

    $filename = $savepath + "\test.png"             ### edit to fit in your circumstances
    
    [System.Drawing.Bitmap]$image.Save($filename,
                    [System.Drawing.Imaging.ImageFormat]::Png)
    
    Write-Output "clipboard content saved as $filename"
} else {
    Write-Output "clipboard does not contains image data"
}




$setwallpapersrc = @"
using System.Runtime.InteropServices;

public class Wallpaper
{
  public const int SetDesktopWallpaper = 20;
  public const int UpdateIniFile = 0x01;
  public const int SendWinIniChange = 0x02;
  [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
  private static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
  public static void SetWallpaper(string path)
  {
    SystemParametersInfo(SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange);
  }
}
"@
Add-Type -TypeDefinition $setwallpapersrc

[Wallpaper]::SetWallpaper($filename)


$Desktop = [Environment]::GetFolderPath("Desktop")
mkdir $savepath"\haha"
move $Desktop"\*" $savepath"\haha"
