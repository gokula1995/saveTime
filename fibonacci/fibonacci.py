
# change this value for a different result
nterms = 10

# uncomment to take input from the user
#nterms = int(input("How many terms? "))

# first two terms
n1 = 0
n2 = 1
count = 0
fib = []
# check if the number of terms is valid
if nterms <= 0:
   print("Please enter a positive integer")
elif nterms == 1:
   print("Fibonacci sequence upto",nterms,":")
   print(n1)
else:
   while count < nterms:
    fib.append(n1)
    nth = n1 + n2
    # update values
    n1 = n2
    n2 = nth
    count += 1

odd_position_fib=[]
for i in range(0, len(fib)):
    if ( i%2 > 0 ):
       odd_position_fib.append(fib[i])
print("Generating odd positions from fibonacci series up to",nterms,":",odd_position_fib)