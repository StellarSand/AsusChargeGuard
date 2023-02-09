# ASUS Charge Guard

ASUS Charge Guard provides a simple and efficient solution to set your battery's maximum power of **RSOC (Relative State Of Charge)** which helps extend the battery's lifespan on ASUS laptops.

This project provides a GNU/Linux alternative to the [Battery Health Charging](https://www.asus.com/us/support/FAQ/1032726) feature offered by ASUS for Windows systems.



## Contents
- [Installation](#installation)
- [Available profiles](#available-profiles)
- [Usage](#usage)
- [Uninstall](#uninstall)
- [Contributing](#contributing)
- [License](#license)



## Installation
**1. Clone this repo:**
```
git clone https://github.com/the-weird-aquarian/AsusChargeGuard.git
```

**2. Move into the project directory:**
```
cd AsusChargeGuard
```

**3. Give executable permissions to the install script:**
```
chmod +x install.sh
```

**4. Run the install script:**
```
./install.sh
```



## Available profiles
Three default profiles are provided similar to the [Battery Health Charging](https://www.asus.com/us/support/FAQ/1032726) feature:
- full (100)
- balanced (80)
- maxlife (60)



## Usage

```
sudo acg <threshold>
```

**Examples:**

```
sudo acg balanced
```

```
sudo acg 60
```

NOTE:
It is recommended to use built in profiles (full, balanced, maxlife).
Custom thresholds are supported, however they will only work if it's supported
by the laptop itself.



## Uninstall
If AsusChargeGuard has been installed, you can remove it by:

**1. Clone this repo (if not done already):**
```
git clone https://github.com/the-weird-aquarian/AsusChargeGuard.git
```

**2. Move into the project directory:**
```
cd AsusChargeGuard
```

**3. Give executable permissions to the uninstall script:**
```
chmod +x uninstall.sh
```

**4. Run the uninstall script:**
```
./uninstall.sh
```



## Contributing
Pull requests can be submitted [here](https://github.com/the-weird-aquarian/AsusChargeGuard/pulls). Any contribution to the project will be highly appreciated.



## License
This project is licensed under the terms of [MIT License](https://github.com/the-weird-aquarian/AsusChargeGuard/blob/main/LICENSE).
