entity dac is
port  (
	ck    : in	bit;
	vdd   : in	bit;
	vss   : in	bit;
	inp     : in	bit_vector (3 downto 0);
	daytime    : in	bit;
	reset : in	bit;
	alarm     : out	bit;
	door    : out	bit
      );
end dac;




architecture fsm of dac is

type statetype is (s0, s1, s2, s3, s4);
-- Signla declaration
 signal ns, cs : statetype;
 -- Synthesis directives
 -- pragma current_state cs
 -- pragma next_state ns
 -- pragma clock ck
 begin
  process (cs, inp, daytime, reset)
  begin
   if (reset='1') then
        alarm <='0';
		door <='0';
        ns<=s0;
   else
     case cs is
		when S0 =>
		if(inp="1101" and daytime='1') then 
			alarm <='0';
			door <='1';		
		elsif (inp="0010") then 
			alarm <='0';
			door <='0';
			ns<=s1;
			
		else 
			alarm <='1';
			door <='0';
			
		end if ;
		
		when s1 => 
		if(inp="1101" and daytime='1') then 
			alarm <='0';
			door <='1';
			ns<=s0;
		
			
		elsif (inp="0110") then 
			alarm <='0';
			door <='0';
			ns<=s2;
			
		else 
			alarm <='1';
			door <='0';
			ns<=s0;
			
		end if ;
		when s2 =>
		if(inp="1101" and daytime='1') then 
			alarm <='0';
			door <='1';
			ns<=s0;
		
		elsif (inp="1010") then 
			alarm <='0';
			door <='0';
			ns<=s3;
				
		else 
			alarm <='1';
			door <='0';
			ns<=s0;
			
		end if ;
		
		when s3 =>
		if(inp="1101" and daytime='1') then 
			alarm <='0';
			door <='1';
			ns<=s0;
		
		elsif (inp="0000") then
			alarm <='0';
			door <='0';
			ns<=s4;
		else 
			alarm <='1';
			door <='0';
			ns<=s0;
			
		end if ;
		
		when s4 =>
		if(inp="1101" and daytime='1') then 
			alarm <='0';
			door <='1';
			ns<=s0;
		
		elsif (inp="0101") then 
			alarm <='0';
			door <='1';
			ns<=s0;
	
		else 
			alarm <='1';
			door <='0';
			ns<=s0;
			
		end if ;
			
	end case;
    end if;
  end process;
  
   process(ck)
  begin
	if(ck = '1' and  ck'event)then
      cs <= ns;
    end if;
  end process;

end FSM;
