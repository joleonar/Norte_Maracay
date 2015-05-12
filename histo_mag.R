# Histograma de magnitud codigo extraido del ssBase
histo_mag <- function (events, yearly = TRUE, smoothline = FALSE, ymax = max(y) * 
            1.05, col = c("grey80", "grey50")) 
{
  catname <- parse(text = events$catname)
  yr <- years1(eval(catname)$time[events$indices])
  if (yearly != TRUE) {
    mth <- months1(eval(catname)$time[events$indices])
    y <- table(mth, yr)
    x <- seq(1, length(y)) - 0.5
    barplot(y, beside = TRUE, space = c(0, 0), ylim = c(0, 
                                                        ymax), col = c(rep(col[2], 12), rep(col[1], 12)), 
            xlab = "Month", ylab = "Number of Events")
  }
  else {
    y <- table(yr)
    x <- seq(1, length(y)) - 0.5
    barplot(y, beside = TRUE, space = 0, ylim = c(0, ymax), 
            col = col[1], xlab = "Años", ylab = "Numero de eventos")
  }
  if (smoothline) 
    lines(supsmu(x, y), col = "blue", lwd = 2)
  box()
  invisible()
}