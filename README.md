NotiView
========

NotiView is a CoreGraphics notification view inspired by @iHaz3 &amp; @abart997.<br />
You could choose the icon, title, description and even the tint color of the view.<br />
It works with iPhone, iPod Touch or iPad, with retina display or not.<br />
The view is dynamically resized according to the detail text length.<br />

<img width=300 src="http://img94.imageshack.us/img94/5396/capturedcrandusimulateu.png"/> <img width=300 src="http://img526.imageshack.us/img526/5396/capturedcrandusimulateu.png"/>


Usage
-----

1) Create the notification view.

	// With default width (300.0f)
	NotiView *nv = [[NotiView alloc] initWithTitle:@"Title" detail:@"detail" icon:[UIImage imageNamed:@"icon"]];

	// Or create it with the width you need
	NotiView *nv = [[NotiView alloc] initWithWidth:300];
    [nv setTitle:@"Title"];
    [nv setDetail:@"detail"]; // this will update the nv height
    [nv setIcon:[UIImage imageNamed:@"icon"]];
    [nv setColor:[UIColor purpleColor]];

2) Add the notification view to a superview
	
    // make sure the notification view is out of the screen to animate it
    CGRect f = nv.frame;
    f.origin.x = [self viewWidth] - f.size.width - offset;
    f.origin.y = -f.size.height;
    nv.frame = f;
    [self.view addSubview:nv];

3) Animate the view 
	
	// show the notification view
    [UIView animateWithDuration:0.4 animations:^{
        nv.frame = CGRectOffset(nv.frame, 0.0, f.size.height+20.0);
    } completion:^(BOOL finished) {
    
    	// hide the view
        [UIView animateWithDuration:0.4 animations:^{
            nv.frame = CGRectOffset(nv.frame, f.size.width+20.0, 0.0);
        } completion:^(BOOL finished) {
            [nv removeFromSuperview];
            [nv release];
        }];
    }];
    
    
Example
-------

With some sandoms strings and colors

<img width=320 src="http://img12.imageshack.us/img12/5396/capturedcrandusimulateu.png"/>

    
License
-------

Copyright (c) 2012, Mathieu Bolard
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
* Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 
* Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

* Neither the name of Mathieu Bolard, mattlawer nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Mathieu Bolard BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Contact
-------

mattlawer08@gmail.com<br />
mathieubolard.com<br />
http://twitter.com/mattlawer
