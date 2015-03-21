from selenium import webdriver
from bs4 import BeautifulSoup
import time
import sys
import os
from pyvirtualdisplay import Display #need to have xvfb installed

display = Display(visible=0, size=(800, 600))
display.start()

completeName = os.path.abspath("/home/chainsaw/homophil/desc_dump/%s" % sys.argv[1])

print 'Working on: ' + str(sys.argv[1])

driver = webdriver.Firefox()
#driver.implicitly_wait(10) # seconds
driver.implicitly_wait(10)
driver.set_page_load_timeout(180)
driver.get("http://weibo.com/u/"+str(sys.argv[1]))
time.sleep(5)
y = BeautifulSoup(driver.page_source)
#print y.find('meta', attrs = {"name":"description"})
driver.close()
display.stop()

#print sys.argv[1]
desc = y.find('meta', attrs = {"name":"description"})["content"]
print desc
t = open(completeName, 'w')
t.write(desc.encode('utf-8'))
t.close()
