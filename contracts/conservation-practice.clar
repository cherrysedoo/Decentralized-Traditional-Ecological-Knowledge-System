;; Conservation Practice Contract
;; Documents sustainable resource management

(define-data-var last-id uint u0)

(define-map conservation-practices
  { id: uint }
  {
    contributor: principal,
    practice-name: (string-utf8 100),
    description: (string-utf8 500),
    resource-type: (string-utf8 50),
    region: (string-utf8 100),
    timestamp: uint
  }
)

(define-public (document-practice
    (practice-name (string-utf8 100))
    (description (string-utf8 500))
    (resource-type (string-utf8 50))
    (region (string-utf8 100)))
  (let
    ((new-id (+ (var-get last-id) u1)))
    (begin
      (var-set last-id new-id)
      (map-set conservation-practices
        { id: new-id }
        {
          contributor: tx-sender,
          practice-name: practice-name,
          description: description,
          resource-type: resource-type,
          region: region,
          timestamp: block-height
        }
      )
      (ok new-id)
    )
  )
)

(define-read-only (get-practice (id uint))
  (map-get? conservation-practices { id: id })
)

(define-read-only (get-last-id)
  (var-get last-id)
)
