class ComplexN{
  constructor(re,im){
  this.re = re;
  this.im = im;
  }
  
  multiply(other){
    return new ComplexN(this.re*other.re-this.im*other.im,this.re*other.im+this.im*other.im);
  }
}
