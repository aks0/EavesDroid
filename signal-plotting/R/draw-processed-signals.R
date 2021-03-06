args <- commandArgs(trailingOnly = TRUE)
path <- "./../../data/all-letters-images"
if (length(args) >= 1) {
   path <- args[1]
}
files <- list.files(path, full.names = TRUE)
files

num_dirs <- length(files)

for (j in 1:num_dirs) {
  letter_files <- list.files(files[j], full.names = TRUE)
  letter_files
  
  num_letter_files <- length(letter_files)
  for (k in 1:num_letter_files) {
    if (regexpr(".csv", letter_files[k], fixed=T)[1] == -1) {
      next
    }
    data <- read.delim(letter_files[k],
                       header = FALSE, sep = ",", quote = "",
                       dec = ".", fill = TRUE, comment.char = "")
    
    # construct the filename for the jpeg
    pos <- regexpr(".gforce.csv", letter_files[k], fixed=T)[1]
    filename <- substr(letter_files[k], 0, pos-1)
    filename <- paste(filename, ".jpg", sep="")
    
    # write the plot to the jpeg
    jpeg(filename)
    plot(as.vector(data$V1), as.vector(data$V2), xlab="time (us)",
         ylab="g-force", main="", type="l")
    dev.off()
    print(filename)
  }
}
