# WDUSBClient
用于实现UI自动化的OC框架, 非侵入式框架

Now, the framework only works on usb connection, so simulator doesn't support(只支持真机设备)
#Create Client(创建客户端)
```
NSString *udid = @"a49bcbd6a9d3b24b8f70b8adde348925a5bfac6e";
FBHTTPOverUSBClient *client = [[WDClient alloc] initWithDeviceUDID: udid];
```
#Start A App on real device(再真机上运行)
###first set the bundle id(先设置bundle id)
`[client setBundleID: @"com.nd.www.TestAppForIOS"]`
###next step, call startApp method(下一步, 调用startApp方法)
`[client startApp]`

