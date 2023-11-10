﻿# Lisa vajalikud Assembly-d
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Loome PowerShell GUI akna
$form = New-Object Windows.Forms.Form
$form.Text = "Administreerimise Tööriistakomplekt"
$form.Size = New-Object Drawing.Size(600, 400)  # Vähendatud akna kõrgust
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::LightGray
$form.ForeColor = [System.Drawing.Color]::Black
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog

# Leia akna keskpunkt
$keskX = ($form.Width - 2 * 250 - 3 * 10) / 2
$keskY = ($form.Height - 5 * 50 - 4 * 10) / 2  # Väiksemad vahed nuppude vahele

$nupuFont = New-Object System.Drawing.Font("Arial", 12, [System.Drawing.FontStyle]::Bold)
$nupuStiil = [System.Windows.Forms.FlatStyle]::Flat

# Lisa veergude pealkirjad
$veerg1Tekst = New-Object Windows.Forms.Label
$veerg1Tekst.Text = "Tööriistad"
$veerg1Tekst.Font = $nupuFont
$veerg1Tekst.Location = New-Object Drawing.Point([System.Math]::Round($keskX), [System.Math]::Round($keskY - 40))
$form.Controls.Add($veerg1Tekst)

$veerg2Tekst = New-Object Windows.Forms.Label
$veerg2Tekst.Text = "Skriptid"
$veerg2Tekst.Font = $nupuFont
$veerg2Tekst.Location = New-Object Drawing.Point([System.Math]::Round($keskX + 260), [System.Math]::Round($keskY - 40))
$form.Controls.Add($veerg2Tekst)

# Lisa nupud aknale ja paigutame need kahes veerus
$nupp1 = New-Object Windows.Forms.Button
$nupp1.SetBounds($keskX, $keskY, 250, 50)
$nupp1.Text = "Tegumihaldur"
$nupp1.FlatStyle = $nupuStiil
$nupp1.Font = $nupuFont
$nupp1.BackColor = [System.Drawing.Color]::SteelBlue
$nupp1.ForeColor = [System.Drawing.Color]::White
$nupp1.Padding = New-Object Windows.Forms.Padding(10)
$nupp1.Add_Click({
    # Nupu 1 klõpsamise funktsiooni kood siin
    Start-Process "taskmgr.exe"
})

$nupp2 = New-Object Windows.Forms.Button
$nupp2.SetBounds($keskX, $keskY + 60, 250, 50)
$nupp2.Text = "Toitenõuded ja -valikud"
$nupp2.FlatStyle = $nupuStiil
$nupp2.Font = $nupuFont
$nupp2.BackColor = [System.Drawing.Color]::SteelBlue
$nupp2.ForeColor = [System.Drawing.Color]::White
$nupp2.Padding = New-Object Windows.Forms.Padding(10)
$nupp2.Add_Click({
    # Nupu 2 klõpsamise funktsiooni kood siin
    control.exe powercfg.cpl
})

$nupp3 = New-Object Windows.Forms.Button
$nupp3.SetBounds($keskX, $keskY + 120, 250, 50)
$nupp3.Text = "Võrguühendus"
$nupp3.FlatStyle = $nupuStiil
$nupp3.Font = $nupuFont
$nupp3.BackColor = [System.Drawing.Color]::SteelBlue
$nupp3.ForeColor = [System.Drawing.Color]::White
$nupp3.Padding = New-Object Windows.Forms.Padding(10)
$nupp3.Add_Click({
    # Nupu 3 klõpsamise funktsiooni kood siin
    control.exe ncpa.cpl
})

$nupp4 = New-Object Windows.Forms.Button
$nupp4.SetBounds($keskX, $keskY + 180, 250, 50)
$nupp4.Text = "Arvuti haldamine"
$nupp4.FlatStyle = $nupuStiil
$nupp4.Font = $nupuFont
$nupp4.BackColor = [System.Drawing.Color]::SteelBlue
$nupp4.ForeColor = [System.Drawing.Color]::White
$nupp4.Padding = New-Object Windows.Forms.Padding(10)
$nupp4.Add_Click({
    # Nupu 4 klõpsamise funktsiooni kood siin
    compmgmt.msc
})

$nupp5 = New-Object Windows.Forms.Button
$nupp5.SetBounds($keskX, $keskY + 240, 250, 50)
$nupp5.Text = "Programmid ja funktsioonid"
$nupp5.FlatStyle = $nupuStiil
$nupp5.Font = $nupuFont
$nupp5.BackColor = [System.Drawing.Color]::SteelBlue
$nupp5.ForeColor = [System.Drawing.Color]::White
$nupp5.Padding = New-Object Windows.Forms.Padding(10)
$nupp5.Add_Click({
    # Nupu 5 klõpsamise funktsiooni kood siin
    control.exe appwiz.cpl
})

$nupp6 = New-Object Windows.Forms.Button
$nupp6.SetBounds($keskX + 260, $keskY, 250, 50)
$nupp6.Text = "Arvuti info"
$nupp6.FlatStyle = $nupuStiil
$nupp6.Font = $nupuFont
$nupp6.BackColor = [System.Drawing.Color]::SteelBlue
$nupp6.ForeColor = [System.Drawing.Color]::White
$nupp6.Padding = New-Object Windows.Forms.Padding(10)
$nupp6.Add_Click({
    # Nupu 6 klõpsamise funktsiooni kood siin
    # Saame riistvara andmed
    $emaplaat = Get-CimInstance Win32_BaseBoard | Select-Object Product
    $protsessor = Get-CimInstance Win32_Processor | Select-Object Name 
    $mälu = Get-CimInstance Win32_PhysicalMemory | Select-Object Manufacturer, DeviceLocator, Capacity
    $kõvakettad = Get-PhysicalDisk | Where-Object MediaType -eq "SSD" 
    $videokaart = Get-CimInstance Win32_VideoController | Select-Object Name
    $võrgukaart = Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true -and $_.IPAddress -ne $null } | Select-Object Description, IPAddress

    # Loome uue akna
    $uusAken = New-Object Windows.Forms.Form
    $uusAken.Text = "Arvuti Info"
    $uusAken.Size = New-Object Drawing.Size(400, 300)
    $uusAken.StartPosition = "CenterScreen"

    # Loome tekstikasti uuele aknale ja kuvame arvuti info
    $infoTekst = New-Object Windows.Forms.TextBox
    $infoTekst.Multiline = $true
    $infoTekst.Size = New-Object Drawing.Size(350, 200)
    $infoTekst.Location = New-Object Drawing.Point(20, 20)
    $infoTekst.ReadOnly = $true
    $infoTekst.AppendText("Emaplaat: $($emaplaat.Product)`r`n")
    $infoTekst.AppendText("Protsessor: $($protsessor.Name)`r`n")
    
    foreach ($mäluriba in $mälu){
        $mäluTootja = $mäluriba.Manufacturer
        $mäluAsukoht = $mäluriba.DeviceLocator
        $mäluSuurus = [math]::Round($mäluriba.Capacity / 1GB, 2)
        $infoTekst.AppendText("Mälu: $mäluTootja - $mäluAsukoht - Suurus: $mäluSuurus GB`r`n")
    }

    foreach ($kõvaketas in $kõvakettad){
        $kõvaketasMudel = $kõvaketas.Model
        $kõvaketasSuurus = [math]::Round($kõvaketas.Size / 1GB, 2)
        $infoTekst.AppendText("Kõvaketas: $kõvaketasMudel - Suurus: $kõvaketasSuurus GB`r`n")
    }

    $ipv4Addresses = $võrgukaart.IPAddress | Where-Object { $_ -match '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b' }
    $infoTekst.AppendText("Võrgukaart: $($võrgukaart.Description) - IP Aadress: $($ipv4Addresses -join ', ')`r`n")

    # Lisa tekstikast uuele aknale
    $uusAken.Controls.Add($infoTekst)

    # Näita uut akent kasutades ShowDialog meetodit
    $uusAken.ShowDialog()
})

    $nupp7 = New-Object Windows.Forms.Button
$nupp7.SetBounds($keskX + 260, $keskY + 60, 250, 50)
$nupp7.Text = "Kasutajate Haldamine"
$nupp7.FlatStyle = $nupuStiil
$nupp7.Font = $nupuFont
$nupp7.BackColor = [System.Drawing.Color]::SteelBlue
$nupp7.ForeColor = [System.Drawing.Color]::White
$nupp7.Padding = New-Object Windows.Forms.Padding(10)
$nupp7.Add_Click({
    # Loome uue akna kasutajate haldamiseks
    # Loome PowerShell GUI akna
    $form = New-Object Windows.Forms.Form
    $form.Text = "Kasutajate haldamine"
    $form.Size = New-Object Drawing.Size(300, 200)  # Muuda akna suurust vastavalt vajadusele
    $form.StartPosition = "CenterScreen"
    $form.BackColor = [System.Drawing.Color]::LightGray
    $form.ForeColor = [System.Drawing.Color]::Black
    $form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog

    # Loome tekstikastid kasutajanime ja parooli sisestamiseks
    $kasutajanimiSilt = New-Object Windows.Forms.Label
    $kasutajanimiSilt.Text = "Kasutajanimi:"
    $kasutajanimiSilt.Location = New-Object Drawing.Point(20, 20)
    $form.Controls.Add($kasutajanimiSilt)

    $kasutajanimiTekst = New-Object Windows.Forms.TextBox
    $kasutajanimiTekst.Location = New-Object Drawing.Point(120, 20)
    $form.Controls.Add($kasutajanimiTekst)

    $paroolSilt = New-Object Windows.Forms.Label
    $paroolSilt.Text = "Parool:"
    $paroolSilt.Location = New-Object Drawing.Point(20, 50)
    $form.Controls.Add($paroolSilt)

    $paroolTekst = New-Object Windows.Forms.TextBox
    $paroolTekst.PasswordChar = "*"  # Maskeeri parooli sisestatud tähed
    $paroolTekst.Location = New-Object Drawing.Point(120, 50)
    $form.Controls.Add($paroolTekst)

    # Lisa nupud "Lisa" ja "Kustuta"
    $nuppLisa = New-Object Windows.Forms.Button
    $nuppLisa.Text = "Lisa"
    $nuppLisa.AutoSize = $true
    $nuppLisa.Location = New-Object Drawing.Point(50, 100)
    $nuppLisa.Add_Click({
        # Nupu "Lisa" klõpsamise funktsioon
        $kasutajanimi = $kasutajanimiTekst.Text
        $parool = $paroolTekst.Text
        if (-not [string]::IsNullOrWhiteSpace($kasutajanimi) -and -not [string]::IsNullOrWhiteSpace($parool)) {
            # Loome uue kasutaja
            New-LocalUser -Name $kasutajanimi -Password (ConvertTo-SecureString $parool -AsPlainText -Force) -PasswordNeverExpires:$true
            [System.Windows.Forms.MessageBox]::Show("Kasutaja $kasutajanimi on loodud.")
        } else {
            [System.Windows.Forms.MessageBox]::Show("Kasutajanimi ja parool ei saa olla tühjad.")
        }
    })

    $nuppKustuta = New-Object Windows.Forms.Button
    $nuppKustuta.Text = "Kustuta"
    $nuppKustuta.AutoSize = $true
    $nuppKustuta.Location = New-Object Drawing.Point(170, 100)
    $nuppKustuta.Add_Click({
        # Nupu "Kustuta" klõpsamise funktsioon
        $kasutajanimi = $kasutajanimiTekst.Text
        if (-not [string]::IsNullOrWhiteSpace($kasutajanimi)) {
            # Kustutame kasutaja
            Remove-LocalUser -Name $kasutajanimi -Force
            [System.Windows.Forms.MessageBox]::Show("Kasutaja $kasutajanimi on kustutatud.")
        } else {
            [System.Windows.Forms.MessageBox]::Show("Sisestage kasutajanimi, mida soovite kustutada.")
        }
    })

    # Muuda nuppude värve vastavalt põhiakna nuppudele
    $nuppLisa.BackColor = [System.Drawing.Color]::SteelBlue
    $nuppLisa.ForeColor = [System.Drawing.Color]::White
    $nuppKustuta.BackColor = [System.Drawing.Color]::SteelBlue
    $nuppKustuta.ForeColor = [System.Drawing.Color]::White

    # Lisa elemendid aknale
    $form.Controls.Add($kasutajanimiSilt)
    $form.Controls.Add($kasutajanimiTekst)
    $form.Controls.Add($paroolSilt)
    $form.Controls.Add($paroolTekst)
    $form.Controls.Add($nuppLisa)
    $form.Controls.Add($nuppKustuta)

    # Näita akent modaalselt
    $form.ShowDialog() | Out-Null
})


    
$nupp8 = New-Object Windows.Forms.Button
$nupp8.SetBounds($keskX + 260, $keskY + 120, 250, 50)
$nupp8.Text = "Tume teema"
$nupp8.FlatStyle = $nupuStiil
$nupp8.Font = $nupuFont
$nupp8.BackColor = [System.Drawing.Color]::SteelBlue
$nupp8.ForeColor = [System.Drawing.Color]::White
$nupp8.Padding = New-Object Windows.Forms.Padding(10)
$nupp8.Add_Click({
    # Nupu 8 klõpsamise funktsiooni kood siin
    # Määra Windowsi teema tumedaks
    New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -PropertyType DWORD -Force
    New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -PropertyType DWORD -Force
})

$nupp9 = New-Object Windows.Forms.Button
$nupp9.SetBounds($keskX + 260, $keskY + 180, 250, 50)
$nupp9.Text = "Eemalda Edge"
$nupp9.FlatStyle = $nupuStiil
$nupp9.Font = $nupuFont
$nupp9.BackColor = [System.Drawing.Color]::SteelBlue
$nupp9.ForeColor = [System.Drawing.Color]::White
$nupp9.Padding = New-Object Windows.Forms.Padding(10)
$nupp9.Add_Click({
    # Nupu 9 klõpsamise funktsiooni kood siin
    Get-AppxPackage *MicrosoftEdge* | Remove-AppxPackage
})

$nupp10 = New-Object Windows.Forms.Button
$nupp10.SetBounds($keskX + 260, $keskY + 240, 250, 50)
$nupp10.Text = "Eemalda Cortana"
$nupp10.FlatStyle = $nupuStiil
$nupp10.Font = $nupuFont
$nupp10.BackColor = [System.Drawing.Color]::SteelBlue
$nupp10.ForeColor = [System.Drawing.Color]::White
$nupp10.Padding = New-Object Windows.Forms.Padding(10)
$nupp10.Add_Click({
    # Nupu 10 klõpsamise funktsiooni kood siin
    # Keela Windows Search / Cortana
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0
})

# Lisa nupud aknale
$form.Controls.Add($nupp1)
$form.Controls.Add($nupp2)
$form.Controls.Add($nupp3)
$form.Controls.Add($nupp4)
$form.Controls.Add($nupp5)
$form.Controls.Add($nupp6)
$form.Controls.Add($nupp7)
$form.Controls.Add($nupp8)
$form.Controls.Add($nupp9)
$form.Controls.Add($nupp10)

# Sündmuse akna aktiveerimiseks
$form.Add_Shown({
    $form.Activate()
})

# Käivita PowerShell GUI aken modaalselt
[Windows.Forms.Application]::Run($form)