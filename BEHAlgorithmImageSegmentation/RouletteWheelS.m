function j = RouletteWheelS(P)
r = rand;
C = cumsum(P);
j = find(r <= C, 1, 'first');
end