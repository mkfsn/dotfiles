#!/usr/bin/env python


from pyquery import PyQuery as pq
import requests


def main():
    url = "http://rate.bot.com.tw/xrt?Lang=zh-TW"
    r = requests.get(url)
    text = r.text.encode(r.encoding)
    update_time = pq(text).find("p.text-info > span.time").text().split()[-1]
    jpy_rate = pq(text).find("table tbody tr:eq(7) td:eq(2)").text()
    print '[%s] %s' % (update_time, jpy_rate)


if __name__ == '__main__':
    main()
