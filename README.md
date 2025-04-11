# Communication and Control for Computer Peripheral Devices

This project demonstrates how to communicate with and control peripheral devices using the **PIC18F4550** microcontroller and a **C# WinForms** application. It supports multiple communication methods including **USB**, **Bluetooth (COM)**, **Ethernet**, and **Wi-Fi**.

Firmware is developed using **mikroC PRO for PIC**.

## 📦 Project Structure

```text
communication-and-control-for-computer-peripheral-devices/
│
├── COM-Bluetooth/           # Serial communication via Bluetooth
├── Ethernet/                # Ethernet communication (ENC28J60)
├── USB/                     # USB HID communication
├── Wifi/                    # Wi-Fi communication (ESP8266)
├── assets/                  # Images and diagrams
├── example/                 # C# WinForms GUI project
├── Bai_tap_ve_nha_Ver8.pdf  # Documentation and exercises (Vietnamese)
└── LICENSE                  # MIT License
```

## 🛠 Tools Used

### Hardware

- PIC18F4550 microcontroller
- HC-05/HC-06 Bluetooth module
- ESP8266 Wi-Fi module
- ENC28J60 Ethernet module
- USB connection for PC interface

### Software

- **mikroC PRO for PIC** – for writing and compiling firmware
- **mikroProg Suite** – for programming the chip
- **Visual Studio** – for developing the WinForms GUI
- .NET Framework with:
	- `System.IO.Ports` for Serial COM
	- `System.Net.Sockets` for TCP/IP

## 🚀 Getting Started

### 🔧 mikroC Firmware

1. Open a `.mcppi` project in one of the protocol folders (e.g. `USB/`, `COM-Bluetooth/`).
2. Write and compile code in mikroC.
3. Upload firmware to the PIC18F4550 using mikroProg.

### 🖥️ C# GUI (WinForms)

1. Navigate to `example/`.
2. Open the `.sln` file in Visual Studio.
3. Build and run the GUI.
4. Select the communication method and COM port or IP.

## 📜 License

Licensed under the [MIT License](LICENSE).
