(use-modules
  (guix packages)
  ((guix licenses) #:prefix license:)
  (guix download)
  (guix build-system gnu)
  (gnu packages)
  (gnu packages autotools)
  (gnu packages guile)
  (gnu packages guile-xyz)
  (gnu packages pkg-config)
  (gnu packages texinfo)
  (gnu packages cran))

(package
  (name "seqeval")
  (version "0.1")
 ;; (source "./seqeval-0.1.tar.gz")
(source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "git://github.com/mbcladwell/seqeval.git")
                      (commit "18a88fb0ca871ae3bab693f9fb384328f90c8844")))
                (sha256 (base32 "0zq216apqdb3d97vprr7z5hl66ab4al95iavsr14n32p2954sfw2"))
               ;; (file-name (git-file-name name version))
		))

  (build-system gnu-build-system)
  (arguments `(	#:phases (modify-phases %standard-phases
					(add-after 'unpack 'patch-prefix
						   (lambda* (#:key inputs outputs #:allow-other-keys)
						     (substitute* '("./scripts/seqeval.sh"
								    "./app.R")
								  (("abcdefgh")
								   (assoc-ref outputs "out" )) )
						     #t))
					(add-before 'install 'copy-app
						    (lambda* (#:key outputs #:allow-other-keys)
						      (let* ((out  (assoc-ref outputs "out")))
							     (install-file "app.R" out)     			     	     
							     #t)))
					(add-before 'install 'copy-executable
						    (lambda* (#:key outputs #:allow-other-keys)
						      (let* ((out  (assoc-ref outputs "out"))
							     (bin-dir (string-append out "/bin"))	    							     
							     )            				       
							(install-file "scripts/seqeval.sh" bin-dir)
							#t)))
				(add-before 'install 'copy-seqs
						    (lambda* (#:key outputs #:allow-other-keys)
						      (let* ((out  (assoc-ref outputs "out"))
							     )            				       
							(install-file "./*.txt" out)
							#t)))
					(add-after 'install 'wrap-seqeval
						   (lambda* (#:key inputs outputs #:allow-other-keys)
						     (let* ((out (assoc-ref outputs "out"))
							    (bin-dir (string-append out "/bin"))					   
							    (dummy (chmod (string-append out "/bin/seqeval.sh") #o555 ))) ;;read execute, no write
						       (wrap-program (string-append out "/bin/seqeval.sh")
								     `( "PATH" ":" prefix  (,bin-dir) ))
						       #t)))					
	      ) ))
  (native-inputs
    `(("autoconf" ,autoconf)
      ("automake" ,automake)
      ("pkg-config" ,pkg-config)
      ("texinfo" ,texinfo)))
  (inputs `(("guile" ,guile-3.0)
	    ("r-seqinr" ,r-seqinr)
	    ("r-shiny" ,r-shiny)))
  (propagated-inputs `(
		       ;;("r" ,r)
		       ))
  (synopsis "")
  (description "")
  (home-page "www.labsolns.com")
  (license license:gpl3+))

