/* ESP32-S3: the reserved RF bank is 0x3FCC0000..0x3FCDFFFF (DAC data at 0x3FCD0000). */
ASSERT(_heap_start <= 0x3fcc0000, "Static data overlaps the RF DAC bank; reduce IRAM/BSS usage")
