#include <avr/io.h>

void delay(unsigned long d)
{
	volatile unsigned long i;
	for(i = 0; i < d; i++);
}

int main(void)
{
	DDRB = 0xFF;		//direction of portb - output (diodes)
	DDRC = 0x00;		//direction of portc - input (keypad)
	PORTC = 0xFF;		//pull-up
	
	volatile int var = 0;
	
	while(1)
	{
		//S1 => increment
		if(!(PINC & (1<<PC0)))
		{
			var++;
			delay(100000);
		}
		//S2 => decrement
		if(!(PINC & (1<<PC1)))
		{
			var--;
			delay(100000);
		}
		//S3 => stop
		if(!(PINC & (1<<PC2)))
		{
			delay(100000);
		}
		//S4 => clear
		if(!(PINC & (1<<PC3)))
		{
			var = 0;
			delay(100000);
		}
		
		PORTB = var;
	}
	
	return 0;
}