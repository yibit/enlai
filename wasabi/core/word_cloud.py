#!/bin/python
# encoding=utf8

import jieba
from wordcloud import WordCloud, STOPWORDS
import argparse


def parseArgs():
    parser = argparse.ArgumentParser(
        prog='cloud', description='A tool to generate word cloud for data')
    parser.add_argument('-c',
                        '--cloud',
                        default="cloud.png",
                        help='path to save cloud data')
    parser.add_argument('-d', '--data', default="", help='path of the data')
    parser.add_argument('-f',
                        '--font',
                        default="",
                        help='path to the font for word cloud')
    parser.add_argument('-s',
                        '--stopwords',
                        default="wasabi/stopwords/stop_words.txt",
                        help='path to the data of stop word')
    return parser.parse_args()


def stopWords(data_path):
    with open(data_path, "r", encoding="utf-8") as fp:
        stop_words = [s.rstrip() for s in fp.readlines()]

    return stop_words


def cloud(data_path, font_path, wc_path, stop_word_path):
    with open(data_path, encoding="utf-8") as f:
        data = f.read()

    items = jieba.lcut(data)
    text = ' '.join(items)

    stopwords = stopWords(stop_word_path)
    wc = WordCloud(font_path=font_path,
                   width=1000,
                   height=700,
                   background_color='white',
                   max_words=100,
                   stopwords=stopwords)

    wc.generate(text)
    wc.to_file("images/" + wc_path)


if __name__ == "__main__":
    cloud(data_path=parseArgs().data,
          font_path=parseArgs().font,
          wc_path=parseArgs().cloud,
          stop_word_path=parseArgs().stopwords)
