%% Eigenvalues of random low-rank matrices and random bivariate functions
% Yuji Nakatsukasa, April 2017

%%
% (Chebfun example linalg/Randfuneig.m)

%% 1. Eigenvalues of random matrices
% As is well known [2,3], eigenvalues of large random matrices 
% are distributed uniformly in a disk.
% This is called the circular law and it holds very generally (see [4]); 
% the matrix elements are allowed to come from a variety of random
% variables, as long as they are independent (called universality). Here we verify
% the circular law with a standard Gaussian random matrix. 
% In all cases we scale the entries so that the asymptotic spectral radius converges to 1. 

n = 1000;
A = randn(n)/sqrt(n);
hold off
plot(eig(A),'k.'),hold on
plot(chebfun(@(x)exp(1i*x),[0 2*pi]))
axis(1.2*[-1 1 -1 1]), axis equal

%% 2. Eigenvalues of random low-rank matrices
% Low-rank matrices are everywhere these days. A natural question arises:
% what are the eigenvalues of random low-rank matrices? 
% Specifically, consider matrices given by $AB^T$ where $A,B$ are
% tall-skinny $m\times n$ random matrices. Of course there are $m-n$ eigenvalues at 0.
% Where are the other eigenvalues? An important fact here 
% (which becomes crucial below)
% is that the nonzero eigenvalues are the same as those of
% $B^TA$, which is $n\times n$, hence smaller. 

n = 1000;
m = n*10;   % aspect ratio 10
A = randn(m,n); 
B = randn(m,n);

plot(eig(B'*A)/sqrt(m*n),'k.'), hold on
plot(chebfun(@(x)exp(1i*x),[0 2*pi]))
axis(1.2*[-1 1 -1 1]), axis equal

%%
% The eigenvalues again appear to lie uniformly in a disk! 
% A difficulty in explaining this is that here the elements aren't exactly independent. 
% Most results in the literature on random matrices concern i.i.d.
% elements. Nonetheless, recent studies [1,5] explain the phenomenon:
% the eigenvalues of $AB^T$ lie in a disk, but generally not uniformly. 
% More precisely, denoting by $k=m/n$ the aspect ratio, 
% the eigenvalue density at radius $r(0<r<1)$ converges as $n\rightarrow \infty$
% almost surely to $g(r,k) = k/\sqrt{(1-k)^2+4kr^2}$. Note that as $k\rightarrow \infty$, 
% $g(r,k)$ converges to the
% constant $1$, independent of $r$. 
% This indicates that as we take the limit where the 
% aspect ratio tends to infinity (while $m,n\rightarrow \infty$), the
% eigenvalue distribution converges to the uniform distribution over the unit disk. 

%%
% Here is a qualitative explanation: As $m/n\rightarrow \infty$, the columns of 
% the matrices $A,B$ become closer to orthogonal, and so there is an
% orthogonal $m\times m$ matrix $Q$ such that
% $QA\approx \big[I_n, 0\big]^T$ ($Q$ would also be random),
% and then the eigenvalues $AB^T$, which are the same as those of $(QB)^T(QA)$,
% are approximately those of the top $n\times n$ block of $QB$, which has 
% elements that are i.i.d. 

%% 3. Eigenvalues of a product of random matrices
% Let's illustrate this. For a product of two random square matrices, 
% the eigenvalues are markedly clustered near the origin:

n = 1000;
m = n; % we just changed this from n*10 in the low-rank case
A = randn(m,n); 
B = randn(m,n);

plot(eig(B'*A)/sqrt(m*n),'k.'), hold on
plot(chebfun(@(x)exp(1i*x),[0 2*pi]))
axis(1.2*[-1 1 -1 1]), axis equal

%%
% One can play with the aspect ratio and see that the larger $m/n$ is, the
% more uniform the eigenvalue distribution becomes. 


%% 4. Eigenvalues of random (low-rank) bivariate functions
% Now we explore the continuous analogue. 
% We construct a random bivariate function, generated by a new feature 
% randnfun2: this generates a random bivariate function 
% obtained by forming a function of random Fourier coefficients (with support in a disk), 
% then restricting the domain to a smaller square. 
% Let's generate such a function and look at the eigenvalues: here,
% we examine the eigenvalues of the Fredholm integral operator whose kernel
% is the bivariate function (we only compute the nonzero eigenvalues, using again (only more crucially)
% the identity $eig(AB) = eig(BA)$, as there are infinitely many eigenvalues at 0). 

dt = 0.01;                             % max wavenumber 2pi/dt
f = randnfun2([-1,1,-1,1],dt,'norm');  % normalized randum function 
ei = eig(f);
disp(['Number of nonzero eigenvalues: ',num2str(length(ei))])
clf,plot(ei,'k.'),hold on
plot(chebfun(@(x)exp(1i*x),[0 2*pi]))
axis(1.2*[-1 1 -1 1]), axis equal

%%
% Again we see eigenvalues in a disk; are they uniformly distributed? It
% looks like they might be, although perhaps there is room for debate. 
% We perhaps expect them to be so, as we can regard $f(x,y)$ as $A(y)B(x)^T$ where $A,B$ are quasimatrices, i.e.,
% matrices of size $\infty \times n$, that is, the aspect ratio is
% $m/n=\infty$.  
%

%% 5. References
% 
% 1. Burda, Z. and Jarosz, A. and Livan, G. and Nowak, M. A. and Swiech, A.,
% Eigenvalues and singular values of products of rectangular Gaussian
% random matrices, Physical Review E., 82(6),061-114,2010.
% 
% 2. J. Ginibre, Statistical ensembles of complex, quaternion, and real matrices, J. Math. Phys. 6, 440, 1965.
% 
% 3. M. L. Mehta, Random Matrices, Academic Press, 2004. 
%
% 4. T. Tao, V. Vu, Random matrices: Universality of ESDs and the circular law, 
% The Annals of Probability, 38(5), 2023--2065, 2010,
% 
% 5. X. Zeng, Limiting empirical distribution for eigenvalues of products of random rectangular matrices, 
% Statistics & Probability Letters, 126, 33--40, 2017.  
% 
