;; Knowledge Registration Contract
;; Records Indigenous environmental practices

(define-data-var last-id uint u0)

(define-map knowledge-records
  { id: uint }
  {
    contributor: principal,
    title: (string-utf8 100),
    description: (string-utf8 500),
    location: (string-utf8 100),
    timestamp: uint,
    category: (string-utf8 50)
  }
)

(define-public (register-knowledge
    (title (string-utf8 100))
    (description (string-utf8 500))
    (location (string-utf8 100))
    (category (string-utf8 50)))
  (let
    ((new-id (+ (var-get last-id) u1)))
    (begin
      (var-set last-id new-id)
      (map-set knowledge-records
        { id: new-id }
        {
          contributor: tx-sender,
          title: title,
          description: description,
          location: location,
          timestamp: block-height,
          category: category
        }
      )
      (ok new-id)
    )
  )
)

(define-read-only (get-knowledge (id uint))
  (map-get? knowledge-records { id: id })
)

(define-read-only (get-last-id)
  (var-get last-id)
)
