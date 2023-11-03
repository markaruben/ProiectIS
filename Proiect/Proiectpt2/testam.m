puteri = [];
puteri1 =nchoosek([0 1 2 3],2);

for i = 0:3
  for j =0:3
    if (i + j<= 3)
      puteri = [puteri; i j]; % Salvare combinație
    end
  end
end