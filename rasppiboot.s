.section .text
.global _start

_start:
    bl uart_init         // Initialize UART for text output
    bl hdmi_init        // Initialize HDMI for graphical display
    bl sd_init          // Initialize SD card for kernel loading
    bl fs_init          // Initialize secure filesystem support
    bl decrypt_boot_partition  // Decrypt boot partition before accessing kernel images
    bl integrity_check  // Perform integrity check on kernel images
    bl draw_menu        // Draw graphical boot menu with UI enhancements

wait_for_key:
    bl uart_getc        // Read keypress from UART
    cmp w0, '1'
    beq load_os1
    cmp w0, '2'
    beq load_os2
    cmp w0, '3'
    beq load_os3
    cmp w0, '4'
    beq load_os4
    cmp w0, '5'
    beq load_os5
    cmp w0, '6'
    beq load_os6
    cmp w0, '7'
    beq load_os7
    cmp w0, '8'
    beq load_os8
    cmp w0, '9'
    beq load_os9
    cmp w0, '0'
    beq load_os10
    cmp w0, '-'
    beq load_os11
    cmp w0, '='
    beq load_os12

    b wait_for_key  // Loop if invalid key

// OS Loading Routines
load_os1:  ldr x0, =os1_kernel;  bl secure_load_kernel;  b _start
load_os2:  ldr x0, =os2_kernel;  bl secure_load_kernel;  b _start
load_os3:  ldr x0, =os3_kernel;  bl secure_load_kernel;  b _start
load_os4:  ldr x0, =os4_kernel;  bl secure_load_kernel;  b _start
load_os5:  ldr x0, =os5_kernel;  bl secure_load_kernel;  b _start
load_os6:  ldr x0, =os6_kernel;  bl secure_load_kernel;  b _start
load_os7:  ldr x0, =os7_kernel;  bl secure_load_kernel;  b _start
load_os8:  ldr x0, =os8_kernel;  bl secure_load_kernel;  b _start
load_os9:  ldr x0, =os9_kernel;  bl secure_load_kernel;  b _start
load_os10: ldr x0, =os10_kernel; bl secure_load_kernel;  b _start
load_os11: ldr x0, =os11_kernel; bl secure_load_kernel;  b _start
load_os12: ldr x0, =os12_kernel; bl secure_load_kernel;  b _start

// Secure Kernel Loader
secure_load_kernel:
    bl fs_read_kernel    // Securely read kernel from SD card using encrypted filesystem
    bl verify_signature  // Verify digital signature of the kernel image
    bl jump_to_kernel    // Jump to kernel execution if verification succeeds
    ret

// Initialization Functions
uart_init:   ret
hdmi_init:   ret
sd_init:     ret
fs_init:     ret
integrity_check: ret
decrypt_boot_partition: ret
draw_menu:
    bl clear_screen    // Clear screen before drawing menu
    bl draw_background // Draw UI background
    bl draw_os_list    // Display OS selection list in a grid format
    bl draw_highlight  // Highlight the selected OS
    ret

// SD Card and Filesystem Functions
fs_read_kernel:   ret
verify_signature: ret
jump_to_kernel:   ret

// UART Functions
uart_puts:   ret
uart_getc:   ret

// Graphical Functions
clear_screen:    ret
 draw_background: ret
draw_os_list:    ret
draw_highlight:  ret

// Data Section
.section .data
menu_msg:   .asciz "Select OS (1-9,0,-,=) | Hotkeys: F1-F12\n"
os1_kernel: .asciz "kernel1.img"
os2_kernel: .asciz "kernel2.img"
os3_kernel: .asciz "kernel3.img"
os4_kernel: .asciz "kernel4.img"
os5_kernel: .asciz "kernel5.img"
os6_kernel: .asciz "kernel6.img"
os7_kernel: .asciz "kernel7.img"
os8_kernel: .asciz "kernel8.img"
os9_kernel: .asciz "kernel9.img"
os10_kernel: .asciz "kernel10.img"
os11_kernel: .asciz "kernel11.img"
os12_kernel: .asciz "kernel12.img"
