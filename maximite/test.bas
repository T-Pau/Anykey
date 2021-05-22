mode 1,8,0 ,frame

sub frame
  cls
  for i = 0 to 8
  	print i, keydown(i)
  end for
end sub
