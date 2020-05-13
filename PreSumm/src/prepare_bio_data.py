import json
import requests 
from bs4 import BeautifulSoup 
import argparse
import glob 

def generate_data(data_path, saving_path):
  print("saving_path is", saving_path)
  with open(data_path) as f:
    data = json.load(f)
    for n_ques in range(0,len(data["questions"])):
      snip = data["questions"][n_ques]["snippets"]
      for n_snip in range(0, len(snip)):
        link = data["questions"][n_ques]['snippets'][n_snip]['document']
        summ = data["questions"][n_ques]['snippets'][n_snip]['text'] 
        r = requests.get(link) 
        soup = BeautifulSoup(r.content, 'html5lib') 
        try:
          if data["questions"][n_ques]['snippets'][n_snip]['beginSection'] == "title":
            text = soup.find('title').string
          elif data["questions"][n_ques]['snippets'][n_snip]['beginSection'] == "abstract":
            text =  soup.find("div", {"class": "abstr"}).p.string  
          if text!= None and summ!=None:
            f= open(f"{saving_path}raw_story_{n_ques}{n_snip}.story","w+")
            f.write(text + "\n\n" + "@highlight" + "\n\n" + summ)
            f.close()
            print("saved to",saving_path,"_raw_story_",n_ques,n_snip,".story")
        except:
          print("sorry, couldnt get data from link",link)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("-data_path", default='/h/narora/PreSumm/src/bio_data/test_7b/')
    parser.add_argument("-saving_path", default='/scratch/gobi2/narora/data/raw_stories1/test_7b/')
    args = parser.parse_args()
    list_data_path = glob.glob(args.data_path+"*.json")
    print("list_data_path ", list_data_path)     
    for data_path in list_data_path:
      generate_data(data_path, args.saving_path)   