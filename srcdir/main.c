#include <wm_base.h>
#include <wm_gpio.h>
#include <wm_gpio_afsel.h>

void SystemInit(void)
{
}

#if 0
void wm_gpio_config(void)
{
	/* must call first */
	wm_gpio_af_disable();

	/* UART0_TX-PA04 UART0_RX-PA05 */
	wm_uart0_tx_config(WM_IO_PA_04);
	wm_uart0_rx_config(WM_IO_PA_05);

	/* UART1_RX-PB11  UART1_TX-PB12 */
	wm_uart1_rx_config(WM_IO_PB_11);
	wm_uart1_tx_config(WM_IO_PB_12);

	/*MASTER SPI configuratioin*/
	wm_spi_cs_config(WM_IO_PB_15);
	wm_spi_ck_config(WM_IO_PB_16);
	wm_spi_di_config(WM_IO_PB_17);
	wm_spi_do_config(WM_IO_PB_18);
}
#endif

void io_init(void)
{
	/* must call first */
	wm_gpio_af_disable();

	/* LED init */
	tls_gpio_cfg(WM_IO_PA_13, WM_GPIO_DIR_OUTPUT, WM_GPIO_ATTR_PULLHIGH);
    tls_gpio_cfg(WM_IO_PA_14, WM_GPIO_DIR_OUTPUT, WM_GPIO_ATTR_PULLHIGH);
    tls_gpio_cfg(WM_IO_PA_15, WM_GPIO_DIR_OUTPUT, WM_GPIO_ATTR_PULLHIGH);
}

int main(void)
{
	io_init();


	

	return 0;
}

