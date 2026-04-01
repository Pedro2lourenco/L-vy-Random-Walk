
x0 = 0.
y0 = 0.
xn = 0.
yn = 0.

a = 2*runif(1)

d = 0.1

N = 200

X <- c()
Y <- c()

for (i in 1:N)
{
  
  theta = runif(1,0,2*pi)
  
  dx = d*(runif(1)^(-1/a))*cos(theta)
  dy = d*(runif(1)^(-1/a))*sin(theta)
  
  xn = x0 + dx
  yn = y0 + dy
  
  if(xn*xn + yn*yn < 4)
  {
    x0 = xn
    y0 = yn
  }
  
  X[i] <- x0
  Y[i] <- y0
  
}

# --------- Plot styling ---------


par(
  bg = "white",        
  mar = c(5, 5, 2, 2), 
  las = 1,            
  cex.axis = 1.2,      
  cex.lab = 1.4        
)

# Plot trajectory
plot(X, Y,
     type = "l",
     lwd = 2,                 
     col = "black",
     asp = 1,                 
     xlab = "X",
     ylab = "Y",
     xlim = c(-2.5, 2.5),
     ylim = c(-2.5, 2.5),
     axes = TRUE             
)


axis(1, at = seq(-2, 2, 1))
axis(2, at = seq(-2, 2, 1))


box(lwd = 1.5)


theta <- seq(0, 2*pi, length.out = 300)
lines(2*cos(theta), 2*sin(theta),
      col = "red",
      lwd = 2,
      lty = 2)

png("levy_plot.png", width = 800, height = 800,res = 72)

# --------- Save data ---------

data <- data.frame(X, Y)

write.table(data,
            file = 'Traj_levy.dat',
            row.names = FALSE,
            col.names = FALSE,
            sep = '\t')

