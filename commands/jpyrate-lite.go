package main

import (
	"fmt"
	"net"
	"net/http"
	"net/url"
	"os"
	"regexp"

	"github.com/mkfsn/errors"
	"golang.org/x/net/html"
)

var (
	re = regexp.MustCompile(`(?s)日圓 \(JPY\).*本行現金賣出.*(0[.][\d]+).*本行即期買入.*南非幣 \(ZAR\)`)
)

func main() {
	resp, err := http.Get("https://rate.bot.com.tw/xrt?Lang=zh-TW")
	checkErr(err)

	z := html.NewTokenizer(resp.Body)
	for i := 0; i < 1053; i += 1 {
		z.Next()
	}
	fmt.Println(z.Token())

	// doc, err := html.Parse(resp.Body)
	// checkErr(err)
	// /html/body/div[1]/main/div[4]/div/table/tbody/tr[8]/td[3]
	// found := false
	// var f func(*html.Node)
	// f = func(n *html.Node) {
	// 	if n.Type == html.ElementNode && n.Data == "tr" {
	// 		td := n.FirstChild.NextSibling
	// 		for _, a := range td.Attr {
	// 			if a.Key != "data-table" || a.Val != "幣別" {
	// 				break
	// 			}
	// 			div := td.FirstChild.NextSibling.FirstChild.NextSibling
	// 			for _, b := range div.Attr {
	// 				if b.Key != "class" || b.Val != "sp-div sp-japan-div" {
	// 					break
	// 				}
	// 				fmt.Println(td.NextSibling.NextSibling.NextSibling.NextSibling.FirstChild.Data)
	// 				found = true
	// 			}
	// 		}
	// 	}
	// 	for c := n.FirstChild; c != nil && !found; c = c.NextSibling {
	// 		f(c)
	// 	}
	// }
	// f(doc)
}

func checkErr(err error) {
	if err == nil {
		return
	}

	defer os.Exit(1)
	e, ok := errors.Catch(err, ((*net.DNSError)(nil)))
	if ok {
		dnsErr := e.(*net.DNSError)
		fmt.Printf("[%T] %v\n", dnsErr, dnsErr.Err)
		return
	}

	urlErr, ok := err.(*url.Error)
	if !ok {
		fmt.Printf("[%T] %v\n", err, err)
		return
	}

	netErr, ok := urlErr.Err.(*net.OpError)
	if !ok {
		fmt.Printf("[%T] %v\n", urlErr, urlErr.Err)
		return
	}

	dnsErr, ok := netErr.Err.(*net.DNSError)
	if !ok {
		fmt.Printf("[%T] %v\n", netErr, netErr.Err)
		return
	}

	fmt.Printf("[%T] %+v\n", dnsErr, dnsErr.Err)
}
