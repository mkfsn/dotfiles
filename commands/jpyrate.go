package main

import (
	"fmt"
	"io/ioutil"
	"net"
	"net/http"
	"net/url"
	"os"
	"strconv"
	"time"

	"github.com/PuerkitoBio/goquery"
	"github.com/mkfsn/errors"
)

const (
	tmpFile = "/tmp/jpyrate"
)

func init() {
	if _, err := os.Stat(tmpFile); os.IsNotExist(err) {
		os.Create(tmpFile)
	}
}

func main() {
	var first bool

	resp, err := http.Get("https://rate.bot.com.tw/xrt?Lang=zh-TW")
	checkErr(err)

	doc, err := goquery.NewDocumentFromReader(resp.Body)
	resp.Body.Close()
	checkErr(err)

	updateTime, err := time.Parse("2006/01/02 15:04", doc.Find("p.text-info > span.time").Text())
	checkErr(err)

	jpyRate, err := strconv.ParseFloat(doc.Find("table tbody tr").Eq(7).Find("td").Eq(2).Text(), 64)
	checkErr(err)

	b, err := ioutil.ReadFile(tmpFile)
	checkErr(err)

	if string(b) == "" {
		first = true
	}

	oldRate, err := strconv.ParseFloat(string(b), 64)
	if !first {
		checkErr(err)
	}

	switch {
	case first:
		fmt.Printf("[%s] %.4f\n", updateTime.Format("15:04"), jpyRate)
	case jpyRate < 0.277:
		fmt.Printf("#[fg=colour5][%s] %.4f#[default]", updateTime.Format("15:04"), jpyRate)
	case oldRate < jpyRate:
		fmt.Printf("#[fg=colour1][%s] %.4f#[default]", updateTime.Format("15:04"), jpyRate)
	case oldRate > jpyRate:
		fmt.Printf("#[fg=colour2][%s] %.4f#[default]", updateTime.Format("15:04"), jpyRate)
	default:
		fmt.Printf("#[fg=colour4][%s] %.4f#[default]", updateTime.Format("15:04"), jpyRate)
	}

	err = ioutil.WriteFile(tmpFile, []byte(fmt.Sprintf("%v", jpyRate)), 0644)
	checkErr(err)
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
