General Information
===============================
 
This website aims mainly at providing RF test data for the LibreSDR/ZynqSDR platform. I struggled to find anything 
showing the performance of this device in a controlled environment, therefore decided to do it myself.

There no single official owner/manufacturer of this platform, information is scarce and mainly provided
by the community.

This main page will also provide general information few links that I think are useful to know about

Hardware
-------------

The LibreSDR (also known as ZynqSDR) is a platform based on the ADALM-PLUTO from Analog Devices.
It is encased in an aluminium shell which looks and feels quite decent

.. figure:: assets/figures/zynqsdr.png
   :align: center
   :scale: 50 %

   LibreSDR / ZynqSDR

It can be bought in a variety of places such as Ebay, Aliexpress, Banggood... Depending on the source the marking
on the aluminium case might change but the board inside is the same.
As far as I know the current/latest PCB revision is **"rev5"**. Schematics can be found here: 
https://github.com/F5OEO/tezuka_fw/discussions/72.
My own device is from Hamgeek and the case marking matches the one shown by `MartinSKNDE <https://github.com/F5OEO/tezuka_fw/discussions/72#discussioncomment-13402802>`__

.. figure:: assets/figures/zynqsdr_pcb.png
            :align: center
            :scale: 50 %

            LibreSDR PCB

These are the specs, according to `Hamgeek <https://www.hgeek.com/products/hamgeek-adi-pluto-70mhz-6ghz-sdr-software-defined-radio-ad936x-for-libiio-iioscope-sdrsharp-matlab>`__

+----------------------------+-------------------------------------------------------------------------------------------------+
| Feature                    | Description                                                                                     |
+============================+=================================================================================================+
| FPGA                       | XC7020-2CLG400I  with 2-core Cortex A9                                                          |
+----------------------------+-------------------------------------------------------------------------------------------------+
| RAM                        | 1GB 32bit wide DDR3 1066MHz                                                                     |
+----------------------------+-------------------------------------------------------------------------------------------------+
| Flash                      | 32MB QSPI, also support micro SD card                                                           |
+----------------------------+-------------------------------------------------------------------------------------------------+
| RFIC                       | AD9363 (Can be "hacked" to AD9361 or AD9364) with 2 Transmit + 2 Receive channels               |
+----------------------------+-------------------------------------------------------------------------------------------------+
| ADC/DAC resolution         | 12 bits                                                                                         |
+----------------------------+-------------------------------------------------------------------------------------------------+
| Max Sampling rate          | 61.44 Msps                                                                                      |
+----------------------------+-------------------------------------------------------------------------------------------------+
| Max bandwidth              | 20 MHz (AD9363 mode) or 56 MHz (AD9364/61 mode)                                                 |
+----------------------------+-------------------------------------------------------------------------------------------------+
| Frequency range            | 325~3800 MHz (AD9363 mode) or 70~6000MHz (AD9364/61 mode)                                       |
+----------------------------+-------------------------------------------------------------------------------------------------+
| Clock                      | VCTCXO 40MHZ 0.5ppm, with external clock input                                                  |
+----------------------------+-------------------------------------------------------------------------------------------------+
| Connections                | USB 2.0 OTG + USB debug (Serial) + Gigabit ethernet. USB connectors are Type C                  |
+----------------------------+-------------------------------------------------------------------------------------------------+

Drivers and Libraries
----------------------

**Windows** drivers and Libraries I needed to use the device:

- :guilabel:`USB driver`: https://github.com/analogdevicesinc/plutosdr-m2k-drivers-win/releases
- :guilabel:`Libiio`: https://github.com/analogdevicesinc/libiio/releases
- :guilabel:`pyadi-iio` (Python module for Libiio, necessary if you want to control your device with Python scripts): https://github.com/analogdevicesinc/pyadi-iio?tab=readme-ov-file


Firmwares
----------------------

Default firmware
~~~~~~~~~~~~~~~~~~~~

By default my device shipped with an unknown firmware based on the PlutoSDR firmware v0.37, dubbed **"v0.37-dirty"**.

In the device I received the stock firmware:

- Is in "AD9363" mode, ie **limited to the standard frequency range of 325-3800MHz / 20MHz bandwidth**
- Is configured in **1TX-1RX** only (so TX2 and RX2 port unusable)
- Has ethernet enabled by default (some forums seem to say this is not the case but it was on mine):

    .. figure:: assets/figures/linux_ethernet_config.png
        :align: center
        :scale: 80 %

        Ethernet configuration

    .. note::

        At the time of writing I have not tested ethernet yet, only USB

Alternative firmwares
~~~~~~~~~~~~~~~~~~~~~

Most users seem to switch to alternative firmwares. Among the most popular ones:

- :guilabel:`Tezuka` from F5OEO: https://github.com/F5OEO/tezuka_fw
    This firmware is built in many different versions (for different platforms) and adds many new functionalities, as well as support for other open-source projects such as Maia SDR

- :guilabel:`libresdr` from hz12opensource: https://github.com/hz12opensource/libresdr
    This firmware focuses mainly on overclocking and increasing continuous sampling rate

These two repositories contain convenient SD card images: 

#. Format an SD card in FAT32
#. Simply extract the content of the release ZIP file onto the SD card

    .. figure:: assets/figures/sd_card.png
            :align: center
            :scale: 60 %

            SD card preparation

#. Insert it in the LibreSDR and plug it in: the SDR will boot from the SD card instead of the internal flash. 

    .. todo:: screenshot

This method has the advantage that the internal flash remains untouched, eliminating the risk of bricking the device.


Analog devices links
---------------------

- :guilabel:`AD9363`: https://www.analog.com/en/products/ad9363.html

- :guilabel:`ADALM PLUTO`: https://www.analog.com/en/resources/evaluation-hardware-and-software/evaluation-boards-kits/ADALM-PLUTO.html

- :guilabel:`Customization`: https://wiki.analog.com/university/tools/pluto/users/customizing

"Extended capabilities"
------------------------

An AD9363-based device can be set as an AD9364/61 for extended capabilities.
The :guilabel:`Customization` page explains the different possible configurations and commands to use.
The process is also summarised here.

Configuration
~~~~~~~~~~~~~~~

- Plug the device to your computer using the USB port. Windows should enumerate a COM port

    .. todo:: add picture

- Connect to that serial port using a tool like TeraTerm or similar with the settings :guilabel:`9600,N,8,1`

- Connect to the device with :guilabel:`username: root` and :guilabel:`password: analog`

    .. todo:: confirm + add picture

- Type the following commands:

    .. code-block::

        fw_setenv attr_name compatible
        fw_setenv attr_val <rfic>
        fw_setenv compatible <rfic>
        fw_setenv mode <mode>
        reboot

    The options for ``<rfic>`` and ``<mode>`` are given in the Modes section below

    You can get the current state of the device by typing:

        .. code-block::

            fw_printenv attr_name
            fw_printenv attr_val

    For example if you get:

        .. code-block::

            fw_printenv attr_name
            --> Error: "attr_name" not defined
            fw_printenv attr_val
            --> Error: "attr_val" not defined

    It means those attributes are not defined, the device is therefore in AD9363 mode. This should be the default state.

Example:

.. todo:: add picture

Available Modes
~~~~~~~~~~~~~~~~

+----------------+------------------------+-----------------+---------------+--------------------+
| <rfic>         | <mode>                 | LO tuning range | Max bandwidth |  Max sampling rate |
+================+========================+=================+===============+====================+
| AD9363         | 1r1t (1x RX + 1x TX)   | 325 - 3800 MHz  | 20 MHz        |  61.44 Msps        |       
+                +------------------------+-----------------+---------------+--------------------+
|                | 2r2t (2x RX + 2x TX)   | 325 - 3800 MHz  | 20 MHz        |  30.72 Msps        |       
+----------------+------------------------+-----------------+---------------+--------------------+
| AD9364         | 1r1t (1x RX + 1x TX)   | 70 - 6000 MHz   | 56 MHz        |  61.44 Msps        |       
+----------------+------------------------+-----------------+---------------+--------------------+
| AD9361         | 1r1t (1x RX + 1x TX)   | 70 - 6000 MHz   | 56 MHz        |  61.44 Msps        |       
+                +------------------------+-----------------+---------------+--------------------+
|                | 2r2t (2x RX + 2x TX)   | 70 - 6000 MHz   | 56 MHz        |  30.72 Msps        |       
+----------------+------------------------+-----------------+---------------+--------------------+

Example, to put the device in AD9361 / 2r2t mode, type:

.. code-block::

        fw_setenv attr_name compatible
        fw_setenv attr_val ad9361
        fw_setenv compatible ad9361
        fw_setenv mode 2r2t
        reboot