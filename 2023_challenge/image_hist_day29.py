import pandas as pd

import cv2
import numpy as np
import matplotlib.pyplot as plt

imgpath = "snake_river_Tetons.TIF"
img = cv2.imread(imgpath,0)

fig, axs = plt.subplots(1, 2, figsize=(15, 15))
plt.subplot(1, 2, 2)
plt.imshow(img, cmap='gray')
plt.title('Ansel Adams - The Tetons & Snake River')
plt.xticks([])
plt.yticks([])
plt.subplot(1,2,1)
hist, bins = np.histogram(img.ravel(), 256, [0,255])
# plt.xlim([0,255])
plt.hist(img.ravel(), bins=255, color="dimgray", )
plt.title('Grayscale pixel values for image on right')
plt.ylabel("Pixel Count")
plt.xlabel("Color value 0 to 255")
txt = "Graphic: Megan Payne\nImage source: https://catalog.archives.gov/id/519904"
fig.text(.5, .05, txt, ha='left')
plt.show()

