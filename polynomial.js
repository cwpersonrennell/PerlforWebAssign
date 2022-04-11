class ComplexN{
  constructor(re,im){
  this.re = re;
  this.im = im;
  }
  
  multiply(other){
    return new ComplexN(this.re*other.re-this.im*other.im,this.re*other.im+this.im*other.re);
  }
  
  add(other){
    return new ComplexN(this.re+other.re,this.im+other.im);
  }
  
  subtract(other){
    return new ComplexN(this.re - other.re, this.im - other.im);
  }
  
  copy(){
    return new ComplexN(this.re,this.im);
  }
  
  pow(n){
    let result = new ComplexN(1,0);
    for(let i = 0;i<n;i++){
      result = result.multiply(this);
    }
    return result;
  }
  
  get conjugate(){
    return new ComplexN(this.re,-this.im);
  }
  
  get modulus(){
    return Math.sqrt(this.re*this.re+this.im*this.im);
  }
  
  get reciprocal(){
    let den = this.multiply(this.conjugate);
    return new ComplexN(this.re/den.re,this.im/den.re); 
  }
  
  get str(){
    let A = this.re==0?"":this.re;
    let B = this.im==0?"":`${Math.abs(this.im)}i`;
    let signB = this.im<0?"-":"+";
    signB = this.im==0?"":signB;
    if(this.re ==0 && this.im == 0)
      return "0";
    return `${A}${signB}${B}`;
  }
  
  coef(leading=true,variable="x"){    
    let A = this.re==0?"":Math.abs(this.re);
    let B = this.im==0?"":`${Math.abs(this.im)}i`;
    let signB = this.im<0?"-":"+";
    let signA = this.re<0?"-":"+";
    signB = this.im==0?"":signB;
    if(this.re ==0 && this.im == 0)
      return "";
    if(this.re == 1 && this.im == 0)
      return `${variable}`;
    if(this.re == -1 && this.im == 0)
      return `-${variable}`;
    if(this.re == 0)
      if(Math.abs(this.im) == 1)
        return `${signB}${B}i${variable}`; 
    if(leading)
      return `(${this.re}${signB}${B})${variable}`;
    return `+(${signA}${A}${signB}${B})${variable}`;
  }
  
}


class Polynomial{
  constructor(coefs){
    this._polynomial_array = [];
    let n = coefs.length;
    this.degree = n;
    this.n = n;
    for(let i = 0;i<n;i++){
      let coef = coefs[i];
      if(typeof coef == 'number')
        coef = new ComplexN(coef,0);
      this._polynomial_array.push(coef);
    } 
  }
  
  eval(x){
    let result = new ComplexN(0,0);
    if(typeof x == 'number')
      x = new ComplexN(x,0);
    
    for(let i = 0;i<this.n;i++){
      result = result.add(this._polynomial_array[i].multiply(x.pow(i)));
    }
    return result;
  }
  latex(){
    let result = ``;
    let variable = "";
    if(this.deg>1){
      variable = `x^{${this.n-1}}`;
      result = `${this._polynomial_array[this.n-1].coef(true,variable)}`;
    }
    for(let i = this.n-2;i>1;i--){
      variable = `x^{${i}}`;
      result = result+`${this._polynomial_array[i].coef(false,variable)}`;
    }
    result = result+`${this._polynomial_array[1].coef(false,"x")}`;
    result = result+`${this._polynomial_array[0].coef(false,"")}`;
    return result;
  }
}
