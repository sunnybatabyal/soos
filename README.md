# soos
Simple Open Operating System

## Instructions for running

 1. Download / clone the project.
 2. Go to the project directory `cd soos`
 3. Run the make command `make` or `make soos.bin`
 4. Edit your `boot/grub/grub.cfg` and add below code at the end.
 
    ```
    ### BEGINE SOOS ###
    
    menuentry 'SOOS' {
        multiboot /boot/soos.bin
        boot
    }
    
    ### END SOOS ###
    ```
 
 5. Reboot your system.
 6. From the boot menu select **"SOOS"**
 7. Enjoy.
