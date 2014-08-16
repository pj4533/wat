![](wifi_eye.png)
# wat - a simple packet sniffer
wat is a very simple exploration of using the libpcap library on OSX via Swift through a command line interface.

## Goal
The main goal is the creation of a tool for debugging the network traffic of iOS apps, without having to use a proxy tool (such as Charles).  Other goals include:

* keep things simple: network code is hard enough
* keep things modern: most network code is OLD
* learn Swift: its new, I need to learn it

## Notes
* Color CLI output via Swift - not as easy as I'd like.  I had to bridge back to ObjectiveC for this.
* Function pointers in Swift - getting better with XCode6 beta4, but I had to go back to ObjectiveC for this as well.
* Found this code on [Stack Overflow](http://stackoverflow.com/questions/24067085/pointers-pointer-arithmetic-and-raw-data-in-swift) - very useful for low level byte manipulation in Swift:

```
    func read<T>(byteLocation: Int) -> T {
        let bytes = self.rawData.subdataWithRange(NSMakeRange(byteLocation, sizeof(T))).bytes
        return UnsafePointer<T>(bytes).memory
    }
```

## Limitations
* SSL - no proxy means no reading SSL
* Eventually WPA/WPA2 traffic will be decrypted (given proper password), but I havn't figured out this code yet.
* Focusing on IEEE802.11 plus radiotap, for now

## Help & Links
If you want to help out, please fork and make some pull requests.  Here are some links I found useful:
* [tcpdump](http://www.tcpdump.org) - tcpdump source code &  docs
* [Programming with libpcap](http://recursos.aldabaknocking.com/libpcapHakin9LuisMartinGarcia.pdf) - PDF of article from Hackin9 magazine in 2008.  Very old, but nice to read some basics.
* [Radiotap docs](http://www.radiotap.org) - Explains the radiotap header - took me a while to figure this out.  Basically, you just need the (variable) length

## Contact

PJ Gray

- http://github.com/pj4533
- http://twitter.com/pj4533
- pj@pj4533.com

## License

wat is available under the MIT license. See the LICENSE file for more info.

