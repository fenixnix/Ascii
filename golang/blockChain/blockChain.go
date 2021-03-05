package blockChain

import(
	"fmt"
	"bytes"
	"math/big"
	"crypto/rand"
	"crypto/elliptic"
	"crypto/ecdsa"
	"golang.org/x/crypto/sha3"
	"encoding/hex"
	//compress"github.com/ethereum/go-ethereum/crypto"
)

func GenerateKey(){
	randBytes := make([]byte, 64)
	_, err := rand.Read(randBytes)
	if err != nil {
		panic("key generation: could not read from random source: " + err.Error())
	}
	fmt.Printf("Seed:%s\n",hex.EncodeToString(randBytes))
	reader := bytes.NewReader(randBytes)
	var priKey,_ = ecdsa.GenerateKey(elliptic.P256(), reader)
	X,Y := PrvToPub(priKey.D.Bytes(),elliptic.P256())
	fmt.Printf("X:%s,Y:%s\n",hex.EncodeToString(X.Bytes()),hex.EncodeToString(Y.Bytes()))
	//cPubKey := compress.CompressPubkey(& priKey.PublicKey)
	cPubKey := CompressPubKey(priKey.PublicKey);
	fmt.Printf("Compressed:%s\n",hex.EncodeToString(cPubKey))
	fmt.Printf("X:%X\nY:%X\nD:%X\n", priKey.X, priKey.Y, priKey.D)
	fmt.Printf("PriKey:%X\n", priKey.D)
	fmt.Printf("PubKey:%X\n", priKey.PublicKey)
	fmt.Printf("Address:%s\n",hex.EncodeToString(PubkeyToAddress( priKey.PublicKey)))

	r,s,_ :=ecdsa.Sign(rand.Reader,priKey,Keccak256([]byte("hello world!")))
	fmt.Printf("R:%s,S:%s\n",hex.EncodeToString(r.Bytes()),hex.EncodeToString(s.Bytes()))
	//priKey.Sign(rand.Reader,)
}

func PrvToPub(prv []byte,c elliptic.Curve)(X,Y *big.Int){
	return c.ScalarBaseMult(prv);
}

func SignResult(sign []byte)(r,s,v *big.Int){
	tr,ts,tv := big.NewInt(0),big.NewInt(0),big.NewInt(0)
	tr = tr.SetBytes(sign [:66])
	ts = ts.SetBytes(sign [66:130])
	tv = tv.SetBytes(sign [130:])
	return tr,ts,tv
}

//func SignRecover(sign,hash []byte)[]byte{
//	tr,ts := big.NewInt(0),big.NewInt(0)
//	tr = tr.SetBytes(sign[:66])
//	ts = ts.SetBytes(sign[66:130])
//	rn := tr.Inverse(tr)
//	u1:=rn*hash
//	u1 = -u1
//	u2:=rn*ts
//	x,y:=elliptic.P256().ScalarMult(u1,u2)


//}

//uncompressed:0x04 compressed 0x02:Y even 0x03:Y odd
func CompressPubKey(k ecdsa.PublicKey)[]byte{
	tmp := make([]byte,33)
	if k.Y.Bit(0) == 0 {
		tmp[0]=2
	}else{
		tmp[0]=3
	}
	copy(tmp[1:],k.X.Bytes())
	return tmp
}

// Y^2 = X^3+7
//func UnCompressPubKey(X *big.Int)[]byte{
//	X3 := X.Exp(X,big.NewInt(0),nil)
//	Ysq := X3.Add(X3,big.NewInt(7))
//	Y:=Sqrt(Ysq)
//}

type Address []byte //Length 20

func PubkeyToAddress(p ecdsa.PublicKey)Address {
	pubBytes := FromECDSAPub(&p)
	return Keccak256(pubBytes[1:])[12:]
}
   
func FromECDSAPub(pub *ecdsa.PublicKey) []byte {
 if pub == nil || pub.X == nil || pub.Y == nil {
     return nil
 }
 return elliptic.Marshal(elliptic.P256(), pub.X, pub.Y)
}

func Marshal(curve elliptic.Curve, x, y *big.Int) []byte {
 byteLen := (curve.Params().BitSize + 7) >> 3

 ret := make([]byte, 1+2*byteLen)
 ret[0] = 4 // uncompressed point

 xBytes := x.Bytes()
 copy(ret[1+byteLen-len(xBytes):], xBytes)
 yBytes := y.Bytes()
 copy(ret[1+2*byteLen-len(yBytes):], yBytes)
 return ret
}

func Keccak256(data ...[]byte) []byte {
	d := sha3.NewLegacyKeccak256()
	for _, b := range data {
	    d.Write(b)
	}
	return d.Sum(nil)
}
//
//import binascii
//from decimal import *
//
//expected_uncompressed_key_hex = '0450863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B23522CD470243453A299FA9E77237716103ABC11A1DF38855ED6F2EE187E9C582BA6'
//expected_y_hex = expected_uncompressed_key_hex[-64:]
//expected_y_dec = int(expected_y_hex, 16)
//x_hex = expected_uncompressed_key_hex[2:66]
//if expected_y_dec % 2 == 0:
//    prefix = "02"
//else:
//    prefix = "03"
//
//artificial_compressed_key = prefix + x_hex
//
//getcontext().prec = 500
//test_dec = Decimal(int(x_hex, 16))
//y_square_dec = test_dec**3 + 7
//if prefix == "02":
//    y_dec = - Decimal(y_square_dec).sqrt()
//else:
//    y_dec = Decimal(y_square_dec).sqrt()
//
//computed_y_hex = hex(int(y_dec))
//computed_uncompressed_key = "04" + x + computed_y_hex
//
//有关信息,我的输出是：
//
//computed_y_hex = '0X2D29684BD207BF6D809F7D0EB78E4FD61C3C6700E88AB100D1075EFA8F8FD893080F35E6C7AC2E2214F8F4D088342951'
//expected_y_hex = '2CD470243453A299FA9E77237716103ABC11A1DF38855ED6F2EE187E9C582BA6'
//
//谢谢您的帮助！
//您需要在字段中进行计算,这主要意味着您必须在每次计算后用p除以后将数字减少到余数.计算它被称为取模,并在python中写为％p.
//
//在这个领域中的指数可以比仅仅乘法和减少许多次的天真方式更有效地完成.这称为模幂运算. Python的内置指数函数pow(n,e,p)可以解决这个问题.
//
//剩下的问题是找到平方根.幸运的是,secp256k1以特殊的方式选择(),因此取平方根很容易：x的平方根是.
//
//因此,代码的简化版本将变为：
//
//import binascii
//
//p_hex = 'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F'
//p = int(p_hex, 16)
//compressed_key_hex = '0250863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B2352'
//x_hex = compressed_key_hex[2:66]
//x = int(x_hex, 16)
//prefix = compressed_key_hex[0:2]
//
//y_square = (pow(x, 3, p)  + 7) % p
//y_square_square_root = pow(y_square, (p+1)/4, p)
//if (prefix == "02" and y_square_square_root & 1) or (prefix == "03" and not y_square_square_root & 1):
//    y = (-y_square_square_root) % p
//else:
//    y = y_square_square_rooｓ
//
//computed_y_hex = format(y, '064x')
//computed_uncompressed_key = "04" + x_hex + computed_y_hex
//
//print computed_uncompressed_key
//
//


//static int secp256k1_ecdsa_sig_recover(const secp256k1_ecmult_context *ctx,
//	 const secp256k1_scalar *sigr,
//	 const secp256k1_scalar* sigs, 
//	 secp256k1_ge *pubkey, const secp256k1_scalar *message, int recid) {
//    unsigned char brx[32];
//    secp256k1_fe fx;
//    secp256k1_ge x;
//    secp256k1_gej xj;
//    secp256k1_scalar rn, u1, u2;
//    secp256k1_gej qj;
//    int r;

//    if (secp256k1_scalar_is_zero(sigr) || secp256k1_scalar_is_zero(sigs)) {
//        return 0;
//    }

//    secp256k1_scalar_get_b32(brx, sigr);
//    r = secp256k1_fe_set_b32(&fx, brx);
//    (void)r;
//    VERIFY_CHECK(r); /* brx comes from a scalar, so is less than the order; certainly less than p */
//    if (recid & 2) {
//        if (secp256k1_fe_cmp_var(&fx, &secp256k1_ecdsa_const_p_minus_order) >= 0) {
//            return 0;
//        }
//        secp256k1_fe_add(&fx, &secp256k1_ecdsa_const_order_as_fe);
//    }
//    if (!secp256k1_ge_set_xo_var(&x, &fx, recid & 1)) {
//        return 0;
//    }
//    secp256k1_gej_set_ge(&xj, &x);
//    secp256k1_scalar_inverse_var(&rn, sigr);//rn = sigr`取反
//    secp256k1_scalar_mul(&u1, &rn, message);//u1 = rn*message 取反后乘以消息
//    secp256k1_scalar_negate(&u1, &u1);//负数//u1 = -u1
//    secp256k1_scalar_mul(&u2, &rn, sigs);//u2 = rn*sigs
//    secp256k1_ecmult(ctx, &qj, &xj, &u2, &u1);//qj,xj = ctx*(u2,u1)
//    secp256k1_ge_set_gej_var(pubkey, &qj);//pubkey = qj=>
//    return !secp256k1_gej_is_infinity(&qj);
//}
