#include <avr/io.h>

int main(void)
{
    DDRB = 0xFF;		//direction of portb - output (diodes)
	DDRC = 0x00;		//direction of portc - input (keypad)
	PORTC = 0xFF;		//pull-up
	
    while (1) 
    {
		if(!(PINC & (1<<PC0)))
		{
			PORTB = 'A';
		}
		else if(!(PINC & (1<<PC1)))
		{
			PORTB = 'B';
		}
		else if(!(PINC & (1<<PC2)))
		{
			PORTB = 'C';
		}
		else if(!(PINC & (1<<PC3)))
		{
			PORTB = 'D';
		}
		else
		{
			PORTB = 0x00;
		}
    }
	return 0;
}