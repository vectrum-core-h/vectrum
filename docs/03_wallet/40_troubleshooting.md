---
content_title: vectrum-wallet Troubleshooting
---

## How to solve the error "Failed to lock access to wallet directory; is another `vectrum-wallet` running"?

Since `vectrum-cli` may auto-launch an instance of `vectrum-wallet`, it is possible to end up with multiple instances of `vectrum-wallet` running. That can cause unexpected behavior or the error message above.

To fix this issue, you can terminate all running `vectrum-wallet` instances and restart `vectrum-wallet`. The following command will find and terminate all instances of `vectrum-wallet` running on the system:

```sh
pkill vectrum-wallet
```
