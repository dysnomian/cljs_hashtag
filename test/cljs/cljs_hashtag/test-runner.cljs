(ns cljs_hashtag.test-runner
  (:require
   [cljs.test :refer-macros [run-tests]]
   [cljs_hashtag.core-test]))

(enable-console-print!)

(defn runner []
  (if (cljs.test/successful?
       (run-tests
        'cljs_hashtag.core-test))
    0
    1))
