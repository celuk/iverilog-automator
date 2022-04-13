# iverilog-automator
A bash script to traverse all subdirectories, compile with iverilog and test with testbenches. 

## Required Installations
```bash
sudo apt install iverilog
sudo apt install unzip
sudo apt install unrar
```


## Running Script
```bash
cd {your-folder-with-subdirectories-to-test}
chmod +x {your-folder-to-location-of-auto_iver}/auto_iver.sh
{your-folder-to-location-of-auto_iver}/auto_iver.sh
```

e.g.:
```bash
cd /home/shc/odevler
chmod +x /home/shc/iverilog-automator/auto_iver.sh
/home/shc/iverilog-automator/auto_iver.sh
```
