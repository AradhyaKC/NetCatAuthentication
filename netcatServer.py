import http.server
import subprocess

class MyServerHandler(http.server.SimpleHTTPRequestHandler):
    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        request_body = self.rfile.read(content_length)
        request_data = request_body.decode('utf-8')
        params = {}
        for param in request_data.split('&'):
            key, value = param.split('=')
            params[key] = value

        print(self.client_address)
        # print(params)


        result = subprocess.run(['sh', 'checkNetcatFile.sh',params['username'],params['password']], capture_output=True)
        resultString=result.stdout.decode('utf-8')
        # print(len(resultString))

        if(len(resultString)==8):
            result =subprocess.run(['sh', 'AllowIpAddresses.sh',self.client_address[0]], capture_output=True)
            self.wfile.write(str('success').encode("utf-8"))
        else:
            self.wfile.write(str('Netcat Access is restricted').encode("utf-8"))


port = 8000
directory = '.'

serverAddress=('localhost',port)

httpd = http.server.HTTPServer(serverAddress, MyServerHandler)
result =subprocess.run(['sh', 'AllowIpAddresses.sh'], capture_output=True)

print(f"Serving at http://localhost:{port}")
httpd.serve_forever()