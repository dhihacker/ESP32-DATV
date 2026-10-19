if(IDF_TARGET STREQUAL "esp32s3")
    # Xtensa: the RISC-V loops do not assemble here; main.c runs every mode through its C loops.
    set(datv_srcs "main.c")
    set(datv_guard "rf_bank_guard_s3.ld")
else()
    set(datv_srcs "main.c" "lut8.S" "lutg.S" "lutg_psk8.S" "lutg_p8s8.S" "lutg_a16.S" "lutg_a16s8.S" "lutg_a32.S")
    set(datv_guard "rf_bank_guard.ld")
endif()

idf_component_register(SRCS ${datv_srcs}
                       REQUIRES esp_phy esp_wifi nvs_flash esp_timer esp_driver_usb_serial_jtag esp_driver_gpio)

# Fail at link time instead of booting with data in the RF ownership bank.
target_link_libraries(${COMPONENT_LIB} INTERFACE "-Wl,-T${CMAKE_CURRENT_LIST_DIR}/${datv_guard}")
