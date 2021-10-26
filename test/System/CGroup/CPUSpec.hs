module System.CGroup.CPUSpec (
  tests,
) where

import Control.Monad.IO.Class (liftIO)
import Path.IO (resolveDir')
import System.CGroup.CPU
import System.CGroup.Types (Controller (..))
import Test.Sandwich (CoreSpec, describe, it, shouldBe)

tests :: CoreSpec
tests = do
  describe "getCPUQuota" $ do
    it "should return CPUQuota when there is a quota" $ do
      controller <- resolveDir' "test/System/CGroup/testdata-cpu/quota"
      quota <- liftIO $ getCPUQuota (Controller controller)
      quota `shouldBe` CPUQuota 1 2

    it "should return NoQuota when there is no quota" $ do
      controller <- resolveDir' "test/System/CGroup/testdata-cpu/noquota"
      quota <- liftIO $ getCPUQuota (Controller controller)
      quota `shouldBe` NoQuota