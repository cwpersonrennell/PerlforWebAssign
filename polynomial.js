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
}


class Polnomial{
  constructor(coefs){
    this._polynomial_array = [];
    let n = coefs.length;
    for(let i = 0;i<n;i++){
      let coef = coefs[i];
      if(typeof coef == 'number')
        coef = new ComplexN(coef,0);
      this._polynomial_array.append(coef);
    }
    
  }
}
