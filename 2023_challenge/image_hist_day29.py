import cv2
import matplotlib.pyplot as plt

# Get the image pixel data 
imgpath = "snake_river_Tetons.TIF"
img = cv2.imread(imgpath,0)


# Plot the histogram on the left and grayscale of the image on the right.
fig, axs = plt.subplots(1, 2, figsize=(15, 10))
# Histogram subplot
plt.subplot(1,2,1)
plt.hist(img.ravel(), bins=255, color="dimgray", )
plt.title('Grayscale pixel values for image on right')
plt.ylabel("Pixel Count")
plt.xlabel("Color value 0 to 255")

# Grayscale image subplot.
plt.subplot(1, 2, 2)
plt.imshow(img, cmap='gray')
plt.title('Ansel Adams - The Tetons & Snake River')
plt.xticks([])
plt.yticks([])

txt = "Graphic: Megan Payne\nImage source: https://catalog.archives.gov/id/519904"
fig.text(.5, .05, txt, ha='left')
plt.savefig("output/monocrome_hist_plot_day29.png")
