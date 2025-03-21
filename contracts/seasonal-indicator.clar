;; Seasonal Indicator Contract
;; Tracks traditional markers of ecological changes

(define-data-var last-id uint u0)

(define-map seasonal-indicators
  { id: uint }
  {
    observer: principal,
    indicator-name: (string-utf8 100),
    description: (string-utf8 500),
    season: (string-utf8 50),
    observation-date: uint,
    location: (string-utf8 100)
  }
)

(define-public (record-indicator
    (indicator-name (string-utf8 100))
    (description (string-utf8 500))
    (season (string-utf8 50))
    (observation-date uint)
    (location (string-utf8 100)))
  (let
    ((new-id (+ (var-get last-id) u1)))
    (begin
      (var-set last-id new-id)
      (map-set seasonal-indicators
        { id: new-id }
        {
          observer: tx-sender,
          indicator-name: indicator-name,
          description: description,
          season: season,
          observation-date: observation-date,
          location: location
        }
      )
      (ok new-id)
    )
  )
)

(define-read-only (get-indicator (id uint))
  (map-get? seasonal-indicators { id: id })
)

(define-read-only (get-last-id)
  (var-get last-id)
)
