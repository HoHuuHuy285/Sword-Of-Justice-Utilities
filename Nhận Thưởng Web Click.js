window.stopClaim = false; // Gõ 'window.stopClaim = true' để dừng

(async () => {
  const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

  const closePopupIfPresent = async (maxWaitMs = 1000) => {
    const start = Date.now();
    while (Date.now() - start < maxWaitMs) {
      const closeBtn = document.querySelector(".e3-popup-close");
      if (closeBtn) {
        closeBtn.click();
        console.log("[Auto-Claim] Đã tự động đóng Popup phần thưởng!");
        return true;
      }
      await sleep(50); // Kiểm tra lại mỗi 50ms
    }
    return false;
  };

  console.log("🟢 [Super-Fast] Kích hoạt vòng lặp an toàn...");

  while (!window.stopClaim) {
    console.log("Looping...");
    const unclaimedMissions = document.querySelector(
      '[class*="--completedUnclaimed"]',
    );

    if (unclaimedMissions) {
      const button = unclaimedMissions.querySelector(
        '[class*="-mission-action"], .e3-game-button',
      );

      if (button && !button.disabled) {
        const title =
          unclaimedMissions.querySelector("h3")?.innerText || "Nhiệm vụ";
        button.click();
        console.log(`[Super-Fast] 🎯 Đã bấm: "${title}"`);

        // Nghỉ 300ms sau khi bấm để web xử lý API gửi đi
        await closePopupIfPresent(800);
      }
    }

    // 🛡️ ĐIỂM QUAN TRỌNG NHẤT: Bắt buộc sleep ở cuối vòng lặp
    // Giúp bảo vệ CPU không bị kẹt Tight Loop 0ms kể cả khi button bị disabled
    await sleep(100);
  }

  // observer.disconnect();
  console.log("🔴 [Super-Fast] Đã dừng script!");
})();
