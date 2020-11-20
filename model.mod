#set,param,var
param nRows;
set Rows := 1..nRows;

param cashierCount;
set Cashiers := 1..cashierCount;
param cashierLength;

set ProductGroups;
param space {ProductGroups};

var putProduct{ProductGroups, Rows} binary;
var putCashier{Cashiers, Rows} binary;
var rowLength{Rows} >= 0;
var BuildingLength >= 0;

#s.t.
s.t. PutInAllCashiers{c in Cashiers}:
    sum{r in Rows} putCashier[c, r] = 1;

s.t. PutInAllProduct{p in ProductGroups}:
    sum{r in Rows} putProduct[p, r] = 1;

s.t. RowLength{r in Rows}:
    rowLength[r] >= sum{p in ProductGroups} putProduct[p, r] * space[p] + sum{c in Cashiers} putCashier[c, r] * cashierLength;

s.t. SetLongestRow{r in Rows}:
    BuildingLength >= rowLength[r];

#min/max
minimize LongestRow:
    BuildingLength;

#print
solve;
printf "%f\n",BuildingLength;
