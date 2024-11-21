extern "C" void kernel_main() {
    // Set up VGA text mode (example)
    char* video_memory = (char*)0xB8000;
    video_memory[0] = 'H';
    video_memory[1] = 0x07; // White text on black background

    while (1) {
        // Infinite loop
    }
}
